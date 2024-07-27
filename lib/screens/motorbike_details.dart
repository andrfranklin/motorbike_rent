import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/motorbike.dart';
import 'package:motorbikes_rent/providers/brand.dart';
import 'package:motorbikes_rent/widgets/custom_back_arrow.dart';
import 'package:motorbikes_rent/widgets/image_carousel.dart';
import 'package:motorbikes_rent/widgets/motorbike/rental_price_option_card.dart';
import 'package:provider/provider.dart';

class MotorbikeDetails extends StatelessWidget {
  final MotorbikeModel motorbike;

  const MotorbikeDetails({super.key, required this.motorbike});

  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CustomArrowBack(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      motorbike.model,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      brandProvider.findBrand(motorbike.brandId)?.name ?? '',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  )
                ],
              ),
              ImageCarousel(motorbike: motorbike),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(
                              'Alugue agora',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 180,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            RentalPriceOptionCard(
                              motorbike: motorbike,
                              months: 6,
                              discount: 1,
                            ),
                            const SizedBox(width: 12),
                            RentalPriceOptionCard(
                              motorbike: motorbike,
                              months: 3,
                              discount: 0.5,
                            ),
                            RentalPriceOptionCard(
                              motorbike: motorbike,
                              months: 1,
                              discount: 0,
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
