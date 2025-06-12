import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // Firebase is initialized
              return task();
            default :
              // Firebase is still initializing
              return Text('Loading...');
          }
        },
      ),
    );
  }

  Column task() {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Center(
                child: const Text(
                  'Register Form',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: true,
                autocorrect: false,
                controller: _email,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.key),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: _password,
              ), 
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  final email = _email.text.trim();
                  final password = _password.text.trim();
                  try{
                    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, 
                    password: password
                  );
                  print(userCredential);
                  } on FirebaseAuthException catch (e){
                    if(e.code == 'email-already-in-use'){print('Email already registered....');}
                    else if(e.code == 'weak-password'){print('Weak password');}
                    else if(e.code == 'invalid-email'){print('Invalid email');}
                    else{print('Error: '+ e.code);}
                  }
                }, 
                child: const Text('Register'),),
              const SizedBox(height: 10),
              
            ],
          );
  }
}