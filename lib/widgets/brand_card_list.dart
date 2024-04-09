import 'package:flutter/material.dart';
import 'package:motorbikes_rent/data/brand_data.dart';
import 'package:motorbikes_rent/widgets/brand_card.dart';

class BrandCardList extends StatefulWidget {
  const BrandCardList({super.key});
  @override
  _BrandCardListState createState() => _BrandCardListState();
}

class _BrandCardListState extends State<BrandCardList> {
  @override
  Widget build(BuildContext context) {
    var brands = getBrands();

    return ListView.builder(
        itemCount: brands.length,
        // physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return BrandCard(
            brand: brands[index],
            cardIndex: index,
          );
        });
  }
}
