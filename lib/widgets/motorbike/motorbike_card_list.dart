import 'package:flutter/material.dart';
import 'package:motorbikes_rent/providers/motorbike.dart';
import 'package:motorbikes_rent/screens/motorbike_details.dart';
import 'package:motorbikes_rent/widgets/motorbike/motorbike_card.dart';
import 'package:provider/provider.dart';

class MotorbikeCardList extends StatefulWidget {
  final String? findByName;

  const MotorbikeCardList({super.key, required this.findByName});
  @override
  MotorbikeCardListState createState() => MotorbikeCardListState();
}

class MotorbikeCardListState extends State<MotorbikeCardList> {
  @override
  Widget build(BuildContext context) {
    final motorbikeProvider = Provider.of<MotorbikeProvider>(context);
    var motorbikes = widget.findByName != null
        ? motorbikeProvider.motorbikes
            .where((element) => element.model
                .toLowerCase()
                .contains(widget.findByName!.toLowerCase()))
            .toList()
        : motorbikeProvider.motorbikes;

    return ListView.builder(
        itemCount: motorbikes.length,
        // physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MotorbikeDetails(
                            motorbike: motorbikes[index],
                          )),
                );
              },
              child: MotorbikeCard(
                motorbike: motorbikes[index],
                cardIndex: index,
              ));
        });
  }
}
