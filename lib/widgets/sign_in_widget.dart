import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/utils/app_colors.dart';
import 'package:task_app/widgets/button_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignInWidget extends StatelessWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: "Hello",
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "\n start your day...",
                        style: TextStyle(
                            color: AppColors.smallTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold))
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            InkWell(
              onTap: () async {
                final newUser = await _googleSignIn.signIn();
                final googleAuth = await newUser!.authentication;
                final credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken
                );
                UserCredential auth = await FirebaseAuth.instance.signInWithCredential(credential);
                print(auth.user);
                await FirebaseFirestore.instance.collection('users').add({
                  "uid": auth.user!.uid,
                  "displayName": auth.user!.displayName,
                  "email": auth.user!.email,
                  "photoURL": auth.user!.photoURL
                }).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
              },
              child: ButtonWidget(
                  backgroundColor: AppColors.mainColor,
                  text: "Iniciar Sesion",
                  textColor: Colors.white),
            ),
          ],
        ),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/welcome.jpg"))),
      ),
    );
  }
}
