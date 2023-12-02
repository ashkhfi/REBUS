import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart' as role;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class Authservices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //method buat login
  Future<UserCredential?> login(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Periksa role pengguna
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(user.uid).get();
        String role = userSnapshot['role'];

        if (role == 'admin') {
          // Login admin berhasil
          Navigator.pushReplacementNamed(context, '/admin');
        } else {
          // Login pengguna berhasil
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        // Gagal login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal login. Silakan coba lagi.')),
        );
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('User not found.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password.');
        }
      }
      return null;
    }
  }

  Future<UserCredential?> register(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update displayName dengan nama pengguna
      await userCredential.user?.updateDisplayName(name);

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name,
          id: userCredential.user!.uid,
          role: role.Role.user,
        ),
      );
      Future<UserCredential?> register(
          String name, String email, String password) async {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Update displayName dengan nama pengguna
          await userCredential.user?.updateDisplayName(name);

          await FirebaseChatCore.instance.createUserInFirestore(
            types.User(
              firstName: name,
              id: userCredential.user!.uid,
              role: role.Role.user,
            ),
          );
          FirebaseAuth auth = FirebaseAuth.instance;
          User? user = auth.currentUser;

// Membuat objek types.User dari data User dari FirebaseAuth
          types.User typesUser = types.User(
            id: user!.uid,
            firstName: user.displayName ??
                '', // Menggunakan displayName dari FirebaseAuth sebagai nama depan (jika ada)
            imageUrl: '', // Isi dengan URL gambar pengguna jika ada
            metadata: null, // Isi dengan metadata pengguna jika ada
            role: null, // Isi dengan peran pengguna jika ada
          );

          final room = await FirebaseChatCore.instance.createRoom(typesUser);

          return userCredential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            if (kDebugMode) {
              print('The password provided is too weak.');
            }
          } else if (e.code == 'email-already-in-use') {
            if (kDebugMode) {
              print('The account already exists for that email.');
            }
          }
          return null;
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          return null;
        }
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<void> logout1(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
