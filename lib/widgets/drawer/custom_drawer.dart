import 'package:flutter/material.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/utils/api/firebase_api.dart';
import 'package:motorbikes_rent/utils/app_routes.dart';
import 'package:motorbikes_rent/widgets/drawer/custom_drawer_button.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final PageController? controller;

  const CustomDrawer({super.key, this.controller});

  String? getCurrentRouteName(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }

  void animateToPage(int pageNumber) {
    if (controller != null) {
      controller!.animateToPage(
        pageNumber,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    final bool isLoggedIn = customerProvider.isCustomerLoggedIn();

    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          CustomDrawerButton(
              text: 'Home',
              route: '/',
              onPressed: () {
                animateToPage(0);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }),
          const CustomDrawerButton(
            text: 'Meus aluguéis',
            route: AppRoutes.RENTAL_LIST,
          ),
          CustomDrawerButton(
            text: 'Notificações',
            route: '/notifications',
            onPressed: () async {
              await FirebaseApi.initNotifications();
            },
          ),
          CustomDrawerButton(
            text: 'Minha Conta',
            route: AppRoutes.PROFILE,
            onPressed: isLoggedIn
                ? null
                : () {
                    animateToPage(1);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
          ),
          const CustomDrawerButton(
            text: 'Configurações',
            route: '/settings',
          ),
          if (isLoggedIn) const Spacer(),
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
                  Navigator.popUntil(context, ModalRoute.withName('/'));
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
