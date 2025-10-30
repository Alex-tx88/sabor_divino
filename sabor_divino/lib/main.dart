import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/providers/cart_provider.dart';
import 'package:sabor_divino/providers/menu_provider.dart';
import 'package:sabor_divino/screens/home_screen.dart';
import 'package:sabor_divino/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
      ],
      child: MaterialApp(
        title: 'Sabor Divino',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}