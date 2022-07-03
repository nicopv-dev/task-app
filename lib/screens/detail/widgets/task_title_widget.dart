import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskTitleWidget extends StatelessWidget {
  const TaskTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Tareas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          Container(
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_down_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }
}
