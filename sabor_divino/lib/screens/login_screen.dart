import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabor_divino/providers/auth_provider.dart';
import 'package:sabor_divino/screens/register_screen.dart';

// 1. Convertido para StatefulWidget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 2. Chave do formulário e controladores
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // 3. Estado de loading
  bool _isLoading = false;

  // 4. Função para submeter o login
  Future<void> _submitLogin() async {
    // Valida o formulário
    if (!_formKey.currentState!.validate()) {
      return; // Não faz nada se o formulário for inválido
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 5. Chama o método login do provider
      await context.read<AuthProvider>().login(
            _emailController.text,
            _passwordController.text,
          );
      
      // Se o login for bem-sucedido, o 'AuthWrapper' 
      // (que você deve ter configurado no main.dart)
      // irá navegar automaticamente para a HomeScreen.

    } catch (error) {
      // 6. Mostra o erro do login (ex: senha errada)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha no login: ${error.toString()}')),
        );
      }
    } finally {
      // 7. Para o loading
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  // 8. Limpa os controladores quando a tela é descartada
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      // 9. Adicionado o Form com a key
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Bem-vindo de volta!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Entre com seu email e senha para acessar sua conta.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),
              // 10. Convertido para TextFormField
              TextFormField(
                controller: _emailController, // Adicionado controller
                decoration: InputDecoration(
                  labelText: 'Email (Username)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                // Adicionado validator
                validator: (value) =>
                    value == null || !value.contains('@') ? 'E-mail inválido' : null,
              ),
              const SizedBox(height: 16),
              // 11. Convertido para TextFormField
              TextFormField(
                controller: _passwordController, // Adicionado controller
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                obscureText: true,
                // Adicionado validator
                validator: (value) =>
                    value == null || value.length < 6 ? 'Senha deve ter 6+ caracteres' : null,
              ),
              const SizedBox(height: 24),
              // 12. Botão atualizado com o loading
              ElevatedButton(
                onPressed: _isLoading ? null : _submitLogin, // Chama a função
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Entrar'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não tem uma conta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push( // Usamos 'push' para poder voltar
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text('Cadastre-se'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}