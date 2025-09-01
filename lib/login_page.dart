import 'package:app_testing/login_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _message;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _message = "Login berhasil dengan ${_emailController.text}";
      });
    } else {
      setState(() {
        _message = "Login gagal, periksa input";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const Key("emailField"),
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: LoginValidator.validateEmail,
              ),
              TextFormField(
                key: const Key("passwordField"),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: LoginValidator.validatePassword,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                key: const Key("loginButton"),
                onPressed: _submit,
                child: const Text("Login"),
              ),
              if (_message != null) Text(_message!, key: const Key("resultMessage")),
            ],
          ),
        ),
      ),
    );
  }
}