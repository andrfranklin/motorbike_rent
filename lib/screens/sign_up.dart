import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/providers/customer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final CustomerProvider customer = CustomerProvider();
  String? errorMessageName;
  String? errorMessageEmail;
  String? errorMessagePassword;

  bool _validatePassword(String senha) {
    setState(() {
      errorMessagePassword = null;
    });
    if (senha.length < 6) {
      setState(() {
        errorMessagePassword = 'A senha deve ter pelo menos 6 caracteres';
      });
      return false;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(senha)) {
      setState(() {
        errorMessagePassword =
            'A senha deve conter pelo menos um caractere especial';
      });
      return false;
    }

    return true;
  }

  bool _validateEmail(String email) {
    setState(() {
      errorMessageEmail = null;
    });
    String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      setState(() {
        errorMessageEmail = 'Formato de email inválido';
      });
      return false;
    }
    return true;
  }

  bool _validateName(String name) {
    setState(() {
      errorMessageName = null;
    });
    if (name.length < 3 || name.length > 50) {
      setState(() {
        errorMessageName = 'O nome deve ter entre 3 e 50 caracteres';
      });
      return false;
    }
    if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(name)) {
      setState(() {
        errorMessageName = 'O nome não deve conter caracteres especiais';
      });
      return false;
    }
    return true;
  }

  Future<void> _registerUser() async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    try {
      if (_validateName(name) &&
          _validateEmail(email) &&
          _validatePassword(password)) {
        CustomerModel customerData = CustomerModel(name: name, email: email);
        await customer.signUp(customerData, password);
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Tivemos um problema ao tentar  realizar o seu cadastro'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Cadastrar',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                if (errorMessageName != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    errorMessageName!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                if (errorMessageEmail != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    errorMessageEmail!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
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
                if (errorMessagePassword != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    errorMessagePassword!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _registerUser();
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
                    'Cadastrar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Já tem uma conta? Faça login.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
