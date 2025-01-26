import 'package:easy_bill_flutter/constants/g_constants.dart';
import 'package:easy_bill_flutter/modules/bill.dart';
import 'package:easy_bill_flutter/providers/auth_provider.dart';
import 'package:easy_bill_flutter/screens/items/items_screen.dart';
import 'package:easy_bill_flutter/screens/settings/about_screen.dart';
import 'package:easy_bill_flutter/screens/bills/preview_bill_screen.dart';
import 'package:easy_bill_flutter/screens/settings/business_screen.dart';
import 'package:easy_bill_flutter/screens/clients/client_list_screen.dart';
import 'package:easy_bill_flutter/screens/bills/new_bill_screen.dart';
import 'package:easy_bill_flutter/screens/clients/new_client_screen.dart';
import 'package:easy_bill_flutter/screens/items/new_item_screen.dart';
import 'package:easy_bill_flutter/screens/authentication/sign_in.dart';
import 'package:easy_bill_flutter/screens/settings/customer_support_screen.dart';
import 'package:easy_bill_flutter/screens/settings/signature_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../modules/clients.dart';
import '../modules/item.dart';
import '../screens/authentication/sign_up.dart';
import '../screens/authentication/welcome_screen.dart';
import '../screens/bottom_nav_bar.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final loggedIn = authProvider.isLoggedIn;

    // Redirect to the sign-in screen if not logged in
    if (!loggedIn &&
        state.matchedLocation != '/signIn' &&
        state.matchedLocation != '/signUp') {
      return '/WelcomeScreen';
    }
    // Redirect to the bottom navigation bar if logged in and trying to access sign-in
    if (loggedIn &&
        state.matchedLocation == '/signIn' &&
        state.matchedLocation != '/signUp') {
      return '/bottomNavBar';
    }
    return null; // No redirect
  },
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(),
      routes: [
        GoRoute(
            path: 'bottomNavBar',
            builder: (BuildContext context, GoRouterState state) {
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
          builder: (BuildContext context, GoRouterState state) {
            return NewBillScreen();
          },
        ),
        GoRoute(
          path: 'newClientScreen',
          builder: (BuildContext context, GoRouterState state) {
            final Client? client;
            if (state.extra != null) {
              client = state.extra as Client;
            } else {
              client = null;
            }
            return NewClientScreen(client: client);
          },
        ),
        GoRoute(
            path: 'itemsScreen',
            builder: (BuildContext context, GoRouterState state) {
              final ScreenMode? mode;
              if (state.extra != null) {
                mode = state.extra as ScreenMode;
              } else {
                mode = ScreenMode.navigate;
              }
              return ItemsScreen(mode: mode);
            }),
        GoRoute(
          path: 'newItemScreen',
          builder: (BuildContext context, GoRouterState state) {
            final Item? item;
            if (state.extra != null) {
              item = state.extra as Item;
            } else {
              item = null;
            }
            return NewItemScreen(
              item: item,
            );
          },
        ),
        GoRoute(
          path: 'clientListScreen',
          builder: (BuildContext context, GoRouterState state) {
            return ClientListScreen();
          },
        ),
        GoRoute(
          path: 'welcomeScreen',
          builder: (BuildContext context, GoRouterState state) =>
              WelcomeScreen(),
        ),
        GoRoute(
          path: 'businessScreen',
          builder: (BuildContext context, GoRouterState state) =>
              BusinessScreen(),
        ),
        GoRoute(
          path: 'previewBillScreen',
          builder: (BuildContext context, GoRouterState state) {
            Bill? bill;
            if (state.extra != null) {
              bill = state.extra as Bill;
            }
            return PreviewBillScreen(
              bill: bill,
            );
          },
        ),
        GoRoute(
          path: 'aboutScreen',
          builder: (BuildContext context, GoRouterState state) => AboutScreen(),
        ),
        GoRoute(
          path: 'signatureScreen',
          builder: (BuildContext context, GoRouterState state) =>
              SignatureScreen(),
        ),
        GoRoute(
          path: 'customerSupportScreen',
          builder: (BuildContext context, GoRouterState state) =>
              CustomerSupportScreen(),
        ),
      ],
    ),
  ],
);
