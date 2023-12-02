import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/services/auth_services.dart';

import '../widgets/dialog_success_register.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void dispose() {
    // Membersihkan sumber daya saat widget dihapus
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Authservices authservices = Authservices();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
                  child: Image.asset('assets/image/register.png'),
                )
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
              child: Text("Nama"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: namaController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    prefixIcon: Icon(Icons.person),
                    hintText: "Masukan Nama Anda"),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
              child: Text("Email"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Masukan Email anda',
                ),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
              child: Text("Password"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
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
                    String nama = namaController.text;
                    String email = emailController.text;
                    String password = passwordController.text;
                    authservices
                        .register(nama, email, password)
                        .then((userCredential) {
                      if (userCredential != null) {
                        DialogSuccessRegister(context);
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor),
                    shape: MaterialStateProperty.all<StadiumBorder>(
                      const StadiumBorder(),
                    ),
                  ),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("sudah punya akun"),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
