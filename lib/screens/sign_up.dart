import 'package:flutter/material.dart';
import 'package:motorbikes_rent/models/customer.dart';
import 'package:motorbikes_rent/providers/customer.dart';
import 'package:motorbikes_rent/widgets/layouts/base_layout.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CustomerProvider _customer = CustomerProvider();
  String? _errorMessageName;
  String? _errorMessageEmail;
  String? _errorMessagePassword;

  bool _validatePassword(String senha) {
    setState(() {
      _errorMessagePassword = null;
    });
    if (senha.length < 6) {
      setState(() {
        _errorMessagePassword = 'A senha deve ter pelo menos 6 caracteres';
      });
      return false;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(senha)) {
      setState(() {
        _errorMessagePassword =
            'A senha deve conter pelo menos um caractere especial';
      });
      return false;
    }

    return true;
  }

  bool _validateEmail(String email) {
    setState(() {
      _errorMessageEmail = null;
    });
    String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      setState(() {
        _errorMessageEmail = 'Formato de email inválido';
      });
      return false;
    }
    return true;
  }

  bool _validateName(String name) {
    setState(() {
      _errorMessageName = null;
    });
    if (name.length < 3 || name.length > 50) {
      setState(() {
        _errorMessageName = 'O nome deve ter entre 3 e 50 caracteres';
      });
      return false;
    }
    if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(name)) {
      setState(() {
        _errorMessageName = 'O nome não deve conter caracteres especiais';
      });
      return false;
    }
    return true;
  }

  Future<void> _registerUser() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    try {
      if (_validateName(name) &&
          _validateEmail(email) &&
          _validatePassword(password)) {
        CustomerModel customerData = CustomerModel(name: name, email: email);
        await _customer.signUp(customerData, password);
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
      body: BaseLayout(
        child: Center(
          child: SingleChildScrollView(
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                if (_errorMessageName != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    _errorMessageName!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                if (_errorMessageEmail != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    _errorMessageEmail!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                if (_errorMessagePassword != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    _errorMessagePassword!,
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
