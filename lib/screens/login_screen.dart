import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenido", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),),
            ElevatedButton.icon(
                onPressed: () async {
                  final newUser = await _googleSignIn.signIn();
                  final googleAuth = await newUser!.authentication;
                  final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken
                  );
                  UserCredential auth = await FirebaseAuth.instance.signInWithCredential(credential);
                  print(auth.user);
                  final userFind = FirebaseFirestore.instance.collection('users').where("email", isEqualTo: auth.user!.email);

                  if(userFind == null) {
                    await FirebaseFirestore.instance.collection('users').add({
                      "uid": auth.user!.uid,
                      "displayName": auth.user!.displayName,
                      "email": auth.user!.email,
                      "photoURL": auth.user!.photoURL
                    }).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
                  }
                },
                icon: Icon(Icons.person_rounded, size: 20,),
                label: Text("Iniciar Sesion"),
            ),
          ],
        )
      ),
    );
  }
}
