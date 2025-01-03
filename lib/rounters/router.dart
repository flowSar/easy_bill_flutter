import 'package:easy_bill_flutter/screens/new_bill_screen.dart';
import 'package:easy_bill_flutter/screens/sign_in.dart';
import 'package:easy_bill_flutter/screens/sign_up.dart';
import 'package:easy_bill_flutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(),
      routes: [
        GoRoute(
          path: 'signIn',
          builder: (BuildContext context, GoRouterState state) => SignIn(),
        ),
        GoRoute(
          path: 'signUp',
          builder: (BuildContext context, GoRouterState state) => SignUp(),
        ),
        GoRoute(
          path: 'newBillScreen',
          builder: (BuildContext context, GoRouterState state) =>
              NewBillScreen(),
        ),
      ],
    ),
  ],
);
