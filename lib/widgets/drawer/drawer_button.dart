import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final String text;
  final String route;
  final String? currentRoute;
  final Function? onPressed;

  const DrawerButton(
      {super.key,
      required this.text,
      required this.route,
      this.currentRoute,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.black : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
        ),
        onPressed: () {
          onPressed != null
              ? onPressed!()
              : Navigator.of(context).pushNamed(route);
        },
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
