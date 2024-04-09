import 'package:flutter/material.dart';
import 'package:motorbikes_rent/widgets/brand_card_list.dart';
import 'package:motorbikes_rent/widgets/motorbike_card_list.dart';
import 'package:motorbikes_rent/widgets/search_field.dart';

class Home extends StatelessWidget {
  final Function _findByName;
  final String? _filterName;

  const Home(this._findByName, this._filterName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SearchField(
                  findByName: _findByName,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    children: [
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 16),
                              child: Text(
                                "PRINCIPAIS MODELOS",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ]),
                      Container(
                        height: 300,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: MotorbikeCardList(
                          findByName: _filterName,
                        ),
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16, top: 16),
                              child: Text(
                                "NOSSAS MARCAS",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ]),
                      Container(
                        height: 240,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: const BrandCardList(),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ]);
  }
}
