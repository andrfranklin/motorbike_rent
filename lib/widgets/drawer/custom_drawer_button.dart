import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  final String text;
  final String route;
  final Function? onPressed;

  const CustomDrawerButton(
      {super.key, required this.text, required this.route, this.onPressed});

  String? getCurrentRouteName(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = getCurrentRouteName(context) == route;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? const Color.fromRGBO(199, 199, 199, 0.847)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
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
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
