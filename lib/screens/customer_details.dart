import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/customer.dart';

class CustomerDetails extends StatelessWidget {
  final Customer? customer;

  const CustomerDetails({Key? key, this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: customer == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Usuário não está cadastrado'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implementar navegação para tela de cadastro
                    },
                    child: Text('Realizar cadastro'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: TextEditingController(text: customer?.name),
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: TextEditingController(text: customer?.cpf),
                    decoration: InputDecoration(
                      labelText: 'CPF',
                    ),
                  ),
                  // Continue adicionando os campos necessários
                ],
              ),
      ),
    );
  }
}
