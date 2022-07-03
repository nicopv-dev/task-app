import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/models/task.dart';

class TaskService {
  Stream<List<Task>> getUserTasks(String uid, String category) => FirebaseFirestore.instance
      .collection('tasks')
      .where('uid', isEqualTo: uid)
      .where('category', isEqualTo: category)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());

  Stream<List<Task>> getLastUserTask(String uid) => FirebaseFirestore.instance
      .collection('tasks')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());


}