import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/products_overview_page.dart';

import 'auth.dart';

class AuthOrHomePage extends StatefulWidget {
  const AuthOrHomePage({super.key});

  @override
  State<AuthOrHomePage> createState() => _AuthOrHomePageState();
}

class _AuthOrHomePageState extends State<AuthOrHomePage> {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? ProductsOverviewPage() : AuthPage();
  }
}
