import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/screens/dashboard/dashboard_screen.dart';
import 'package:task_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DashboardScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return LoginScreen();
        },
      ),
    );
  }
}

