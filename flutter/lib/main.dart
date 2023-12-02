import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/screens/admin/costume_admin.dart';
import 'package:rental_busana/screens/admin/home_admin.dart';
import 'package:rental_busana/screens/admin/rental_admin.dart';
import 'package:rental_busana/screens/admin/users_admin.dart';
import 'package:rental_busana/screens/home.dart';
import 'package:rental_busana/screens/login.dart';
import 'package:rental_busana/screens/register.dart';
import 'package:rental_busana/screens/splash_screen.dart';
import 'package:rental_busana/screens/user/chat_user.dart';
import 'package:rental_busana/screens/user/detail_item.dart';
import 'package:rental_busana/screens/user/kategori_detail.dart';
import 'package:rental_busana/screens/user/pesanan-berhasil.dart';
import 'package:rental_busana/screens/user/profil.dart';
import 'package:rental_busana/screens/chat/rooms.dart';
import 'models/pakaian.dart';
import 'firebase_options.dart';
import 'screens/user/detail_history_disewa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'assets/font/Monserat.ttf'),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/detail/pakaian') {
            final args =
                settings.arguments as Pakaian; // Mengambil argumen Pakaian
            return MaterialPageRoute(
              builder: (context) =>
                  DetailItem(pakaian: args), // Mengirim argumen ke DetailItem
            );
          }

          if (settings.name == '/kategori/detail') {
            final args =
                settings.arguments as String; // Mengambil argumen Pakaian
            return MaterialPageRoute(
                builder: (context) => DetailKategori(args));
          }
          return null;
        },
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const Login(),
          '/register': (context) => const Register(),
          '/home': (context) => HomePage(),
          '/admin': (context) => HomeAdmin(),
          '/user-admin': (context) => const UserAdmin(),
          '/rental-admin': (context) => RentalAdmin(),
          '/costume-admin': (context) => const CostumeAdmin(),
          '/profil': (context) => Profil(),
          '/berhasil': (context) => const Done(),
          '/chat': (context) => const RoomsPage(),
          '/chat_user': (context) => const ChatUser(),
        },
      ),
    );
  }
}
