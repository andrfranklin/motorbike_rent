import 'package:flutter/material.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
