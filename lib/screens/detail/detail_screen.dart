import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/models/category.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/detail/widgets/task_timeline_widget.dart';
import 'package:task_app/screens/detail/widgets/task_title_widget.dart';
import 'package:task_app/services/task_service.dart';

class DetailScreen extends StatelessWidget {
  Category category;

  DetailScreen(this.category);

  @override
  Widget build(BuildContext context) {
    TaskService _taskService = TaskService();
    User currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(context),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
              )
          ),
          child: Column(
            children: [
              TaskTitleWidget(),
              StreamBuilder<List<Task>>(
                stream: _taskService.getUserTasks(currentUser.uid.toString(), category.title.toString()),
                builder: (context, snapshot) {
                  if(!snapshot.hasData || snapshot.data!.length == 0) {
                    return Center(
                      child: Text("Sin notas"),
                    );
                  }else if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black,),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return TaskTimeLineWidget(snapshot.data![index], category);
                    },
                  );
                },
              )
            ],
          )
        )
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 20,
      ),
      actions: [
        Icon(Icons.more_vert, size: 40,)
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tareas ${category.title}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text('tienes 2 por terminar', style: TextStyle(fontSize: 12, color: Colors.grey[700]),)
          ],
        ),
      ),
    );
  }
}
