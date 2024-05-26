import 'package:flutter/material.dart';
import 'package:motorbikes_rent/providers/brand.dart';
import 'package:motorbikes_rent/widgets/brand/brand_card.dart';
import 'package:provider/provider.dart';

class BrandCardList extends StatefulWidget {
  const BrandCardList({super.key});
  @override
  _BrandCardListState createState() => _BrandCardListState();
}

class _BrandCardListState extends State<BrandCardList> {
  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandProvider>(context);

    return ListView.builder(
        itemCount: brandProvider.brands.length,
        // physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return BrandCard(
            brand: brandProvider.brands[index],
            cardIndex: index,
          );
        });
  }
}
