import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/providers/auth_provider.dart';
import 'package:sabor_divino/screens/home_screen.dart';
import 'package:sabor_divino/screens/login_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late Future<void> _autoLoginFuture;

  @override
  void initState() {
    super.initState();
    // Tenta fazer o login automático uma vez
    _autoLoginFuture = context.read<AuthProvider>().tryAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _autoLoginFuture,
      builder: (context, snapshot) {
        // Enquanto o tryAutoLogin está rodando, mostre um loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Quando o future terminar, comece a ouvir o AuthProvider
        return Consumer<AuthProvider>(
          builder: (context, auth, _) {
            // Se o provider diz que está autenticado, mostre o app
            if (auth.isAuthenticated) {
              return const HomeScreen();
            } else {
              // Se não, mostre a tela de login
              return const LoginScreen();
            }
          },
        );
      },
    );
  }
}