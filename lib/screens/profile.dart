import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motorbike Rental'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Implementar navegação de retorno
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Implementar menu de navegação
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                // final picker = ImagePicker();
                // final pickedFile =
                //     await picker.getImage(source: ImageSource.gallery);
                // if (pickedFile != null) {
                //   customerProvider.updateProfileImage(pickedFile.path);
                // }
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: customerProvider.customer!.profileImage != null
                    ? FileImage(File(customerProvider.customer!.profileImage!))
                    : null,
                child: customerProvider.customer!.profileImage != null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              customerProvider.customer!.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Meus Dados'),
              onTap: () {
                // Implementar navegação para tela de Meus Dados
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Meus Aluguéis'),
              onTap: () {
                // Implementar navegação para tela de Meus Aluguéis
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Minhas notificações'),
              onTap: () {
                // Implementar navegação para tela de Minhas notificações
              },
            ),
            const Divider(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Implementar funcionalidade de logout
              },
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
