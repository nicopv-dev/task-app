import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/models/category.dart';
import 'package:task_app/screens/detail/detail_screen.dart';
import 'package:task_app/services/category_service.dart';

class TasksWidgets extends StatelessWidget {
  const TasksWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryService _categoryService = CategoryService();
    User currentUser = FirebaseAuth.instance.currentUser!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder<List<Category>>(
        future: _categoryService.getCategories(currentUser.uid.toString()),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black, strokeWidth: 5),
            );
          }else if(!snapshot.hasData) {
            return Center(
              child: Text("Sin tareas"),
            );
          }
          return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
              itemBuilder: (BuildContext context, int index) => _buildTask(context, snapshot.data![index])
          );
        },
      )
    );
  }

  Widget _buildAddTask() {
    return Text("Agregar Tarea");
  }

  Widget _buildTask(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(category)));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: category.bgColor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(category.iconData, color: category.iconColor, size: 35,),
            SizedBox(height: 30,),
            Text(category.title!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Row(
              children: [
                _buildTaskStatus(Colors.white, category.iconColor!, "${category.total.toString()} tareas"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color bgColor, Color txColor, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text(text, style: TextStyle(color: txColor),),
    );
  }
}

