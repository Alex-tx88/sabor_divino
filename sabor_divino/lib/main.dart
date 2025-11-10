import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/providers/auth_provider.dart';
import 'package:sabor_divino/providers/cart_provider.dart';
import 'package:sabor_divino/providers/menu_provider.dart';
import 'package:sabor_divino/theme/app_theme.dart';
import 'package:sabor_divino/screens/auth_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
      ],
      child: MaterialApp(
        title: 'Sabor Divino',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        
        // 2. Mude a 'home' para o AuthWrapper
        // Ele vai decidir se mostra o Login ou o Home.
        home: const AuthWrapper(),
      ),
    );
  }
}