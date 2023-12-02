import 'package:flutter/material.dart';
import 'package:rental_busana/models/pakaian.dart';
import 'package:rental_busana/screens/home.dart';
import 'package:rental_busana/screens/login.dart';
import 'package:rental_busana/screens/register.dart';
import 'package:rental_busana/screens/user/detail_item.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments; // Menerima argumen dari rute

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/detail/pakaian':
        // Mengirimkan argumen ke widget DetailItem
        if (args is Pakaian) {
          return MaterialPageRoute(builder: (_) => DetailItem(pakaian: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page Not Found'),
        ),
      );
    });
  }
}
