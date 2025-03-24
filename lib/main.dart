import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CRMApp());
}

class CRMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal CRM',
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}

// 🔒 Simple auth listener
class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Text('Logged in as: ${snapshot.data!.email}'),
            ),
          ); // This will be replaced by your home screen later
        }
        return const AuthScreen();
      },
    );
  }
}
