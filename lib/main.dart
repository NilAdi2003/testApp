import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testapp/views/login_view.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
              final user = FirebaseAuth.instance.currentUser;
              if(user?.emailVerified ?? false){
                print('you are verified');
              }
              else{print('You are not verified');}
              
              return Text('Firebase Initialized');
            default :
              // Firebase is still initializing
              return Text('Loading...');
          }
        },
      ),
    );
  }

 
}







