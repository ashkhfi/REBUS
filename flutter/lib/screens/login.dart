import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/services/auth_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void dispose() {
    // Membersihkan sumber daya saat widget dihapus
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Authservices authservices = Authservices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/image/logo_rebus_auth.png',
                    width: width,
                    // height: 270,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 125,
                  top: 50,
                  child: Image.asset(
                    'assets/image/logo_rebus_ss.png',
                    width: 239,
                    height: 239,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 27, 30, 0),
                  child: Image.asset('assets/image/login.png'),
                )
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 3),
              child: Text("Email"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Masukan Email",
                ),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 3),
              child: Text("Password"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Masukan Password anda',
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 52,
                // padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: ElevatedButton(
                  onPressed: () {
                    String email = emailController.text;
                    String password = passwordController.text;
                    authservices.login(context, email, password);
                    emailController.clear();
                    passwordController.clear();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor),
                    shape: MaterialStateProperty.all<StadiumBorder>(
                      const StadiumBorder(),
                    ),
                  ),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            const Center(
              child: Text(
                "Baru Pertama kali?",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 52,
                // padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    side: const BorderSide(color: AppColors.primaryColor),
                  ),
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showNameDialog(BuildContext context, String? name) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Welcome'),
        content: Text('Welcome, $name!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
              // Lakukan navigasi ke halaman selanjutnya setelah menampilkan dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
