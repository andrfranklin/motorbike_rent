import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/motorbike.dart';
import 'package:motorbikes_rent/providers/brand.dart';
import 'package:motorbikes_rent/utils/base_url.dart';
import 'package:provider/provider.dart';

class MotorbikeCard extends StatelessWidget {
  final Motorbike motorbike;
  final int? cardIndex;
  final _baseUrlStorage = '${BaseUrl.storage}motorbike%2F';

  const MotorbikeCard({super.key, required this.motorbike, this.cardIndex});

  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(
        right: cardIndex != null ? 16 : 0,
        left: cardIndex == 0 ? 16 : 0,
      ),
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Center(
                child: Hero(
                  tag: motorbike.model,
                  child: Image.network(
                    '$_baseUrlStorage${motorbike.images[0]}?alt=media',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              motorbike.model,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                          brandProvider.findBrand(motorbike.brandId)?.name ??
                              '')),
                  Text(
                    'R\$${motorbike.rentalPrice}/M',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )),
          const Padding(
            padding: EdgeInsets.only(top: 18),
            child: Icon(Icons.keyboard_arrow_up,
                shadows: [Shadow(color: Colors.grey, blurRadius: 2)]),
          ),
        ],
      ),
    );
  }
}
