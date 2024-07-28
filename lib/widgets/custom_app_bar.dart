import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldState;
  final double height = kToolbarHeight;

  const CustomAppBar({super.key, required this.scaffoldState});

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Motorbike Rental',
        style: GoogleFonts.mulish(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(customerProvider.isCustomerLoggedIn()
              ? Icons.person_4_rounded
              : Icons.menu),
          onPressed: () => scaffoldState.currentState?.openEndDrawer(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
