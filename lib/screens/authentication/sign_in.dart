import 'package:easy_bill_flutter/components/custom_circular_progress.dart';
import 'package:easy_bill_flutter/components/error_dialog.dart';
import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

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

  void displayErrorDialog(Object e) {
    showErrorDialog(context, 'Sign in error', e.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailValid(String email) {
      // Regular expression to validate email addresses
      final RegExp emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      return emailRegex.hasMatch(email);
    }

    void replaceScreen() {
      context.replace('/bottomNavBar');
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
                ),
                TextFormField(
                  readOnly: isLoading,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) =>
                      isEmailValid(email!) ? null : 'Please insert valid Email',
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
                TextFormField(
                  readOnly: isLoading,
                  controller: _password,
                  obscureText: true,
                  validator: (password) => password!.length < 8
                      ? 'Password is To short < 8 character'
                      : null,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      )),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          bool isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            setState(() {
                              isLoading = true;
                            });
                            bool result = false;
                            try {
                              result = await context.read<AuthProvider>().logIn(
                                  _email.text.trim(), _password.text.trim());
                            } catch (e) {
                              displayErrorDialog(e);
                            }
                            setState(() {
                              isLoading = false;
                            });
                            if (result) {
                              replaceScreen();
                            } else {
                              displayErrorDialog('Sign in failed');
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120, 25),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading ? CustomCircularProgress() : Text('Sign In'),
                ),
                Row(
                  children: [
                    Text("Don't have an account"),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
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
      ),
    );
  }
}
