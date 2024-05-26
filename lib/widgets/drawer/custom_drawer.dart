import 'package:flutter/material.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/widgets/drawer/drawer_button.dart'
    as custom_button;
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final PageController controller;

  const CustomDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)!.settings.name;
    final customerProvider = Provider.of<CustomerProvider>(context);
    final bool isLoggedIn = customerProvider.customer?.id != null;

    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          custom_button.DrawerButton(
            text: 'Minha Conta',
            route: '/account',
            currentRoute: currentRoute,
            onPressed: isLoggedIn
                ? null
                : () {
                    controller.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                    Navigator.pop(context);
                  },
          ),
          custom_button.DrawerButton(
            text: 'Notificações',
            route: '/notifications',
            currentRoute: currentRoute,
          ),
          custom_button.DrawerButton(
            text: 'Pagamentos',
            route: '/payments',
            currentRoute: currentRoute,
          ),
          custom_button.DrawerButton(
            text: 'Configurações',
            route: '/settings',
            currentRoute: currentRoute,
          ),
          if (isLoggedIn) Spacer(),
          if (isLoggedIn)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                ),
                onPressed: () {
                  customerProvider.signOut();
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sair',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
