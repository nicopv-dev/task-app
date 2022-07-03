import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_app/screens/dashboard/widgets/form_widget.dart';

import 'widgets/bar_widget.dart';
import 'widgets/tasks_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarWidget(),
          Container(
            padding: EdgeInsets.all(15),
            child: Text("Tareas", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          Expanded(child: TasksWidgets()),
        ],
      ),
      bottomNavigationBar: _buildBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        backgroundColor: Colors.black,
        onPressed: () => showModalBottomSheet(
            enableDrag: false,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) => _buildShhet()
        ),
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }

  Widget _buildShhet() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormWidget(),
        ],
      ),
    );
  }

  Widget _buildBottonNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            )
          ]
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(label: "Inicio", icon: Icon(Icons.home_rounded, size: 30,)),
            BottomNavigationBarItem(label: "Perfil", icon: Icon(Icons.person_rounded, size: 30,))
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    final User auth = FirebaseAuth.instance.currentUser!;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            child: CircleAvatar(
              backgroundImage: NetworkImage(auth.photoURL!),
            ),
          ),
          SizedBox(width: 10,),
          Text('Hola, ${auth.displayName}!',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () async {
            print("cerrar sesion");
            await _googleSignIn.signOut();
            await FirebaseAuth.instance.signOut();
          },
          child: Icon(Icons.more_vert, color: Colors.black, size: 40,),
        ),

      ],
    );
  }
}
