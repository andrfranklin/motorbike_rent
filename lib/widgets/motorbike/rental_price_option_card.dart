import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/motorbike.dart';
import 'package:motorbikes_rent/widgets/checkout/bottom_sheet_content.dart';

class RentalPriceOptionCard extends StatelessWidget {
  final Motorbike motorbike;
  final int month;
  final double discount;

  const RentalPriceOptionCard(
      {super.key,
      required this.motorbike,
      required this.month,
      required this.discount});

  @override
  Widget build(BuildContext context) {
    final valueDiscounted =
        (motorbike.rentalPrice * month) - (motorbike.rentalPrice * discount);
    final rawValue = motorbike.rentalPrice * month;
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16, right: 6, left: 6),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheetContent(
                month: month,
                motorbikeId: motorbike.id ?? '',
                price: valueDiscounted,
              );
            },
            isScrollControlled:
                true, // Para permitir que o modal ocupe toda a altura da tela
          );
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.grey,
          elevation: 4,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                month > 1 ? "$month Mês" : "$month Meses",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: Container()),
              if (discount > 0) ...[
                Text(
                  "R\$ ${(rawValue).toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
              Text(
                "R\$ ${(valueDiscounted).toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
