import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:easy_bill_flutter/screens/clients/client_list_screen.dart';
import 'package:easy_bill_flutter/screens/bills/new_bill_screen.dart';
import 'package:easy_bill_flutter/screens/clients/new_client_screen.dart';
import 'package:easy_bill_flutter/screens/items/new_item_screen.dart';
import 'package:easy_bill_flutter/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../screens/authentication/sign_up.dart';
import '../screens/authentication/welcome_screen.dart';
import '../screens/bottom_nav_bar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(),
      routes: [
        GoRoute(
            path: 'bottomNaBar',
            builder: (BuildContext context, GoRouterState state) {
              // return Consumer<AuthProvider>(
              //   builder: (context, autoProvider, child) {
              //     if (autoProvider.isLoggedIn) {
              //       return BottomNavBar();
              //     } else {
              //       return SignIn();
              //     }
              //   },
              // );
              return BottomNavBar();
            }),
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
        GoRoute(
          path: 'newClientScreen',
          builder: (BuildContext context, GoRouterState state) =>
              NewClientScreen(),
        ),
        GoRoute(
          path: 'newItemScreen',
          builder: (BuildContext context, GoRouterState state) =>
              NewItemScreen(),
        ),
        GoRoute(
          path: 'clientListScreen',
          builder: (BuildContext context, GoRouterState state) =>
              ClientListScreen(),
        ),
      ],
    ),
  ],
);
