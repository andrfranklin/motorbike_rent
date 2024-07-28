import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/motorbike.dart';
import 'package:motorbikes_rent/utils/api/motorbike.dart';

class ImageCarousel extends StatefulWidget {
  final MotorbikeModel motorbike;
  final motorbikeApi = MotorbikeApi();
  ImageCarousel({super.key, required this.motorbike});

  @override
  ImageCarouselState createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: PageView(
          physics: const BouncingScrollPhysics(),
          onPageChanged: (int page) {
            setState(() {
              currentImage = page;
            });
          },
          children: widget.motorbike.images.map<Widget>((path) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Hero(
                  tag: widget.motorbike.model,
                  child: Image.network(
                    widget.motorbikeApi.imageUrl(path),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
