import 'package:flutter/material.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/utils/app_routes.dart';
import 'package:motorbikes_rent/widgets/layouts/base_layout.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late CustomerProvider customer;

  Future<void> _login() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    try {
      await customer.signIn(email: email, password: password);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tivemos um problema ao tentar realizar o seu login'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    customer = Provider.of<CustomerProvider>(context);
    return BaseLayout(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 5,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.SIGN_UP);
                },
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
