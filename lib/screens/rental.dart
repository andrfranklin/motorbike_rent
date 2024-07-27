import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/rental.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/providers/motorbike.dart';
import 'package:motorbikes_rent/utils/api/rent.dart';
import 'package:motorbikes_rent/utils/base_url.dart';
import 'package:provider/provider.dart';

class RentalScreen extends StatelessWidget {
  final List<RentalModel> rentals = [];
  late MotorbikeProvider motorbikeProvider;
  late CustomerProvider customerProvider;
  final rentalApi = RentApi();
  final _baseUrlStorage = '${BaseUrl.storage}motorbike%2F';

  RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    motorbikeProvider = Provider.of<MotorbikeProvider>(context);
    customerProvider = Provider.of<CustomerProvider>(context);

    rentalApi
        .getRent(customerId: customerProvider.customer?.id! ?? "")
        .then((value) => {rentals.addAll(value)});

    return Scaffold(
      appBar: AppBar(
        title: const Text('Motorbike Rental'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Implementar menu de navegação
            },
          ),
        ],
      ),
      body: Padding(
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
              child: ListView.builder(
                itemCount: rentals.length,
                itemBuilder: (context, index) {
                  final rental = rentals[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: FutureBuilder(
                        future: motorbikeProvider.readMotorbike(
                            motorbikeId: rental.productId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Icon(Icons.error);
                          } else if (snapshot.data?.images[0] != null) {
                            return Image.network(
                              '$_baseUrlStorage${snapshot.data?.images[0]}?alt=media',
                              fit: BoxFit.fitWidth,
                            );
                          } else {
                            return const Icon(Icons.image_not_supported);
                          }
                        },
                      ),
                      title: Text(rental.productId),
                      subtitle: Text(
                          'Válido até: ${rental.endDate.split('-').reversed.join('/')}\nR\$ ${rental.price.toStringAsFixed(2)}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Implementar navegação para detalhes do aluguel
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
