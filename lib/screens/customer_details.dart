import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/address.dart';
import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/widgets/personal_info_form.dart';

class CustomerDetails extends StatefulWidget {
  final Customer? customer;
  final Function createCustomer;

  const CustomerDetails(
      {super.key, this.customer, required this.createCustomer});

  @override
  CustomerDetailsState createState() => CustomerDetailsState();
}

class CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: widget.customer == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Usuário não está cadastrado'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        widget.createCustomer(Customer('', '', DateTime(2024),
                            Address('', 'neighborhood', '')));
                      },
                      child: const Text('Realizar cadastro'),
                    ),
                  ],
                )
              : PersonalInfoForm(
                  customer: widget.customer,
                  createCustomer: widget.createCustomer,
                )),
    );
  }
}
