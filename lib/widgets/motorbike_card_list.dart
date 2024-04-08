import 'package:flutter/material.dart';
import 'package:motorbikes_rent/data/motorbike_data.dart';
import 'package:motorbikes_rent/widgets/motorbike_card.dart';

class MotorbikeCardList extends StatefulWidget {
  final String? findByName;

  const MotorbikeCardList({super.key, required this.findByName});
  @override
  _MotorbikeCardListState createState() => _MotorbikeCardListState();
}

class _MotorbikeCardListState extends State<MotorbikeCardList> {
  @override
  Widget build(BuildContext context) {
    var motorbikes = widget.findByName != null
        ? getMotorbikes()
            .where((element) => element.model
                .toLowerCase()
                .contains(widget.findByName!.toLowerCase()))
            .toList()
        : getMotorbikes();

    return ListView.builder(
        itemCount: motorbikes.length,
        // physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MotorbikeCard(
            motorbike: motorbikes[index],
            cardIndex: index,
          );
        });
  }
}
