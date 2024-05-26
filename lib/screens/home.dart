import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motorbikes_rent/providers/brand.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/providers/motorbike.dart';
import 'package:motorbikes_rent/screens/sign_in.dart';
import 'package:motorbikes_rent/screens/list_motorbike.dart';
import 'package:motorbikes_rent/widgets/drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _filterName;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _findByName(String? name) {
    setState(() {
      _filterName = name!.isNotEmpty ? name : null;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<BrandProvider>(context, listen: false).loadBrands();
    Provider.of<MotorbikeProvider>(context, listen: false).loadMotorbike();
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
            icon: Icon(customerProvider.customer?.id != null
                ? Icons.person_4_rounded
                : Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: CustomDrawer(
        controller: _pageController,
      ),
      body: PageView(
        controller: _pageController,
        children: [ListMotorbike(_findByName, _filterName), const SignInPage()],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -1), // changes position of shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
