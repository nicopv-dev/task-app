import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/models/category.dart';

import '../../../models/task.dart';

class TaskTimeLineWidget extends StatelessWidget {
  final Task task;
  Category category;
  TaskTimeLineWidget(this.task, this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    task.title!.isNotEmpty ?
                    _buildCard(context, task.title.toString(), task.date.toString(), category) : _buildCard(context, "", "", category)
                ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String date, Category category) {
    DateTime temDate = new DateFormat("yyyy-MM-dd hh:mm").parse(date);

    return Container(
      width: MediaQuery.of(context).size.width - 34,
      decoration: BoxDecoration(
        color: category.bgColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          SizedBox(height: 6,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMd().format(temDate)),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: category.iconColor,
                  ),
                  child: Text(DateFormat.Hm().format(temDate), style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
