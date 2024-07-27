import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/motorbike.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/utils/api/rent.dart';
import 'package:provider/provider.dart';

class BottomSheetContent extends StatelessWidget {
  final int months;
  final MotorbikeModel motorbike;
  final rentApi = RentApi();

  BottomSheetContent({
    super.key,
    required this.months,
    required this.motorbike,
  }); // Sua variável

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Período de $months ${months == 1 ? 'mês' : "meses"}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "R\$ ${(motorbike.price).toStringAsFixed(2)}", // Seu valor double
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (customerProvider.customer?.id == null) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Faça login para continuar'),
                        ),
                      );
                      return;
                    }
                    await rentApi.rent(
                        customerId: customerProvider.customer?.id ?? "",
                        motorbikeModel: motorbike,
                        months: months);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (Route<dynamic> route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Cor do background
                  ),
                  child: const Text(
                    'Alugar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Fechar o Bottom Sheet
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
