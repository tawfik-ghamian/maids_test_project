import 'package:flutter/material.dart';

import '../bloc/task_bloc.dart';


class LoginScreen extends StatelessWidget {
  final TaskBloc taskBloc;

  const LoginScreen({Key? key, required this.taskBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                final isLoggedIn = await taskBloc.login(email: email, password: password);
                if (isLoggedIn) {
                  Navigator.pushReplacementNamed(context, '/tasks');
                } else {

                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
