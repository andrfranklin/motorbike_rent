import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/brand.dart';
import 'package:motorbikes_rent/utils/api/brand.dart';

class BrandCard extends StatelessWidget {
  final brandApi = BrandApi();
  final BrandModel brand;
  final int? cardIndex;

  BrandCard({super.key, required this.brand, this.cardIndex});

  @override
  Widget build(BuildContext context) {
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
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Center(
                child: Hero(
                  tag: brand.name,
                  child: Image.network(
                    brandApi.imageUrl(brand.logo),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: Text(
                  brand.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
