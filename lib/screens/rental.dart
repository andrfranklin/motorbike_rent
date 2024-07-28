import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/rental.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/providers/motorbike.dart';
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

  @override
  Widget build(BuildContext context) {
    final motorbikeProvider = Provider.of<MotorbikeProvider>(context);
    final customerProvider = Provider.of<CustomerProvider>(context);

    if (customerProvider.isCustomerLoggedIn() && _rentals.isEmpty) {
      _rentalApi
          .getRent(customerId: customerProvider.customer?.id! ?? "")
          .then((value) => {setState(() => _rentals.addAll(value))});
    }

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
