import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/screens/customer_details.dart';
import 'package:motorbikes_rent/widgets/motorbike_card_list.dart';
import 'package:motorbikes_rent/widgets/search_field.dart';

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
      routes: {
        '/customer_details': (context) => const CustomerDetails(),
      },
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
  Customer? customer;

  _findByName(String? name) {
    setState(() {
      _filterName = name!.isNotEmpty ? name : null;
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SearchField(
            findByName: _findByName,
          ),
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(children: [
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
                      ])))),
        ]),
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
                  offset: Offset(0, -1), // changes position of shadow
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
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
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/customer_details', arguments: customer);
                },
              ),
            ],
          ),
        ));
  }
}
