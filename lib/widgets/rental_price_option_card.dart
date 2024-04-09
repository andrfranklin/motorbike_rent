import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/motorbike.dart';

class RentalPriceOptionCard extends StatelessWidget {
  final Motorbike motorbike;
  final int month;

  const RentalPriceOptionCard(
      {super.key, required this.motorbike, required this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 16, bottom: 16, right: 6, left: 6),
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
          Text(
            "R\$ ${(motorbike.rentalPrice * month).toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
