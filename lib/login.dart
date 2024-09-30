import 'package:flutter/material.dart';

class SimplereadLogin extends StatefulWidget {
  const SimplereadLogin({super.key});

  @override
  State<SimplereadLogin> createState() => _SimplereadLoginState();
}

class _SimplereadLoginState extends State<SimplereadLogin> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: _userController,
              decoration: InputDecoration(
                hintText: "Username",
              ),
            ),
            TextField(
              autofocus: false,
              obscureText: true,
              controller: _passController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: theme.colorScheme.primary,
              child: TextButton(
                onPressed: () {
                  print(_userController.text);
                  print(_passController.text);
                },
                child: Text(
                  "Login",
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
