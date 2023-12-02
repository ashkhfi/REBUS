import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextEditingController namaController =
      TextEditingController(text: "tesk");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 10 - 10,
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Row(
            children: [
              Icon(
                Icons.person_outline_sharp,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 5),
              Text(
                "Informasi Akun",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Container for other widgets
          const SizedBox(
            height: 15,
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height / 10,
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Nama",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      user?.displayName ?? "",
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height / 10,
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      user?.email ?? "",
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height / 10,
            child: const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "********",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.chip,
          borderRadius:
              BorderRadius.circular(10), // Atur radius yang diinginkan
        ),
        child: GestureDetector(
          onTap: () {
            logout();
          },
          child: const Center(
            child: Text(
              'Logout',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
