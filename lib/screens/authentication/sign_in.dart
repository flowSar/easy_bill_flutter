import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SIGN IN',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
              ),
              TextField(
                readOnly: isLoading,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              TextField(
                readOnly: isLoading,
                controller: _password,
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    )),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  final result = await context
                      .read<AuthProvider>()
                      .logIn(_email.text.trim(), _password.text.trim());
                  setState(() {
                    isLoading = false;
                  });
                  if (result) {
                    context.replace('/bottomNavBar');
                  } else {
                    print('Sign-in failed');
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(120, 25),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text('Sign In'),
              ),
              Row(
                children: [
                  Text("Don't have an account"),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: InkWell(
                      onTap: () => context.push('/signUp'),
                      child: Text(
                        'SingUp',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
