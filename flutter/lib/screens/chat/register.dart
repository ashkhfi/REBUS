import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'chat.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _email;
  String? _name;
  FocusNode? _focusNode;
  TextEditingController? _passwordController;
  bool _registering = false;
  TextEditingController? _emailController;
  TextEditingController? _nameController;

  @override
  void initState() {
    super.initState();
    // _firstName = faker.person.firstName();
    // _lastName = faker.person.lastName();
    _emailController = TextEditingController(
      text: _email,
    );
    _focusNode = FocusNode();
    _passwordController = TextEditingController(text: 'Qawsed1-');
    _nameController = TextEditingController(
      text: _name,
    );
  }

  void _register() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _registering = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController!.text,
        password: _passwordController!.text,
      );
      await credential.user?.updateDisplayName(_name);

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: _name,
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=$_email',
        ),
      );

      if (!mounted) return;
      Navigator.of(context)
        ..pop()
        ..pop();
    } catch (e) {
      setState(() {
        _registering = false;
      });

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _passwordController?.dispose();
    _emailController?.dispose();
    _nameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
            child: Column(
              children: [
                TextField(
                  autocorrect: false,
                  autofillHints: _registering ? null : [AutofillHints.email],
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelText: 'Name',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () => _nameController?.clear(),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    _focusNode?.requestFocus();
                  },
                  readOnly: _registering,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  autocorrect: false,
                  autofillHints: _registering ? null : [AutofillHints.email],
                  autofocus: true,
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelText: 'Email',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () => _emailController?.clear(),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    _focusNode?.requestFocus();
                  },
                  readOnly: _registering,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    autocorrect: false,
                    autofillHints:
                        _registering ? null : [AutofillHints.password],
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _passwordController?.clear(),
                      ),
                    ),
                    focusNode: _focusNode,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    onEditingComplete: _register,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                TextButton(
                  onPressed: _registering ? null : _register,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      );
}

void _handlePressed(types.User otherUser, BuildContext context) async {
  final navigator = Navigator.of(context);
  final room = await FirebaseChatCore.instance.createRoom(otherUser);

  navigator.pop();
  await navigator.push(
    MaterialPageRoute(
      builder: (context) => ChatPage(
        otherUser: room.name!,
        room: room,
      ),
    ),
  );
}
