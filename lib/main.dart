import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/screens/customer_details.dart';
import 'package:motorbikes_rent/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mbr',
      theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.black),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.mulishTextTheme()),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _filterName;
  Customer? _customer;
  final PageController _pageController = PageController();

  _findByName(String? name) {
    setState(() {
      _filterName = name!.isNotEmpty ? name : null;
    });
  }

  _createCustomer(Customer customer) {
    setState(() {
      _customer = customer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Do something when menu icon is pressed
              },
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Home(_findByName, _filterName),
            CustomerDetails(
                customer: _customer, createCustomer: _createCustomer)
          ],
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
                icon:
                    Icon(Icons.explore, size: 40, color: Colors.grey.shade600),
                onPressed: null,
                iconSize: 40.0,
                tooltip: 'Explore',
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                disabledColor: Colors.grey.shade600.withOpacity(0.5),
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                constraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
                visualDensity: VisualDensity.standard,
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
        ));
  }
}
