import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/rental.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/providers/motorbike.dart';
import 'package:motorbikes_rent/utils/Database/db.dart';
import 'package:motorbikes_rent/utils/api/motorbike.dart';
import 'package:motorbikes_rent/utils/api/rent.dart';
import 'package:motorbikes_rent/widgets/custom_app_bar.dart';
import 'package:motorbikes_rent/widgets/drawer/custom_drawer.dart';
import 'package:motorbikes_rent/widgets/layouts/base_layout.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  _RentalScreenState createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  final List<RentalModel> _rentals = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _rentalApi = RentApi();
  final _motorbikeApi = MotorbikeApi();

  getRentals(CustomerProvider customerProvider) async {
    if (_rentals.isNotEmpty) return;

    if (customerProvider.isCustomerLoggedIn()) {
      final response = await _rentalApi.getRent(
          customerId: customerProvider.customer?.id! ?? "");

      response.forEach((item) async {
        await DBUtil.upsert('rental', {
          'id': item.id,
          'endDate': item.endDate,
          'startDate': item.startDate,
          'price': item.price,
          'productId': item.productId,
        });
      });

      setState(() => _rentals.addAll(response));
      return;
    }
    final dataList = await DBUtil.getData(table: 'rental');
    final mappedValues = dataList
        .map((item) => RentalModel(
            id: item['id'],
            endDate: item['endDate'],
            price: item['price'],
            productId: item['productId'],
            startDate: item['startDate']))
        .toList();
    setState(() => _rentals.addAll(mappedValues));
  }

  getMotorbike(String motorbikeId, MotorbikeProvider motorbikeProvider) async {
    final dataList =
        await DBUtil.getData(table: 'motorbike', where: 'id = $motorbikeId');
    if (dataList.isEmpty) {
      return motorbikeProvider.readMotorbike(motorbikeId: motorbikeId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final motorbikeProvider = Provider.of<MotorbikeProvider>(context);
    final customerProvider = Provider.of<CustomerProvider>(context);

    getRentals(customerProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scaffoldState: _scaffoldKey,
      ),
      endDrawer: const CustomDrawer(),
      body: BaseLayout(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meus Aluguéis',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _rentals.isEmpty
                    ? const Center(
                        child: Text("Seus aluguéis aparecerão aqui!"))
                    : ListView.builder(
                        itemCount: _rentals.length,
                        itemBuilder: (context, index) {
                          final rental = _rentals[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: FutureBuilder(
                              future: motorbikeProvider.readMotorbike(
                                  motorbikeId: rental.productId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const ListTile(
                                    tileColor: Colors.white70,
                                    leading: CircularProgressIndicator(),
                                    title: Text("Carregando..."),
                                    subtitle: Text('...'),
                                  );
                                } else if (snapshot.hasError) {
                                  return const ListTile(
                                    tileColor: Colors.white70,
                                    leading: Icon(Icons.error),
                                    title: Text("Fail..."),
                                    subtitle: Text('...'),
                                  );
                                } else {
                                  final hasImg =
                                      snapshot.data?.images[0] != null;
                                  return ListTile(
                                    tileColor: Colors.white70,
                                    leading: hasImg
                                        ? Image.network(
                                            _motorbikeApi.imageUrl(
                                                snapshot.data!.images[0]),
                                            fit: BoxFit.fitWidth,
                                            height: 100.0,
                                          )
                                        : const Icon(Icons.image_not_supported),
                                    title: Text(snapshot.data?.model ?? ""),
                                    subtitle: Text(
                                        'Válido até: ${DateFormat('dd/MM/yy').format(DateTime.parse(rental.endDate))}\nR\$ ${rental.price.toStringAsFixed(2)}'),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      // Implementar navegação para detalhes do aluguel
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
