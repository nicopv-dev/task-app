import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

import '../../../services/task_service.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskService _taskService = TaskService();
    User currentUser = FirebaseAuth.instance.currentUser!;

    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 15,),
                StreamBuilder<List<Task>>(
                  stream: _taskService.getLastUserTask(currentUser.uid.toString()),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ultima Tarea Agregada', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                          SizedBox(height: 10,),
                          Text("titulo", style: TextStyle(fontSize: 20, color: Colors.grey[400]),)
                        ],
                      );
                    }else if(snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: Colors.white,);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ultima Tarea Agregada', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                        SizedBox(height: 10,),
                        Text("${snapshot.data![snapshot.data!.length - 1].title}", style: TextStyle(fontSize: 20, color: Colors.grey[400]),)
                      ],
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
