import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app/models/category.dart';

import '../models/task.dart';
import '../utils/app_colors.dart';

class CategoryService {
  Stream<List<Task>> getUserTasksByCategory(String, uid, String category) => FirebaseFirestore.instance
      .collection('tasks')
      .where('uid', isEqualTo: uid)
      .where('category', isEqualTo: category)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());

  Future <List<Category>> getCategories(String uid) async {
    int salud = await FirebaseFirestore.instance.collection('tasks').where('uid', isEqualTo: uid).where('category', isEqualTo: "Salud").get().then((event) => event.docs.length);
    int personales = await FirebaseFirestore.instance.collection('tasks').where('uid', isEqualTo: uid).where('category', isEqualTo: "Personales").get().then((event) => event.docs.length);
    int trabajo = await FirebaseFirestore.instance.collection('tasks').where('uid', isEqualTo: uid).where('category', isEqualTo: "Trabajo").get().then((event) => event.docs.length);
    int otros = await FirebaseFirestore.instance.collection('tasks').where('uid', isEqualTo: uid).where('category', isEqualTo: "Otros").get().then((event) => event.docs.length);

    return [
      Category(
        iconData: Icons.person_rounded,
        title: 'Personales',
        bgColor: AppColors.kYellowLight,
        iconColor: AppColors.kYellowDark,
        btnColor: AppColors.kYellow,
        total: personales == null ? 0 : personales,
      ),
      Category(
        iconData: Icons.cases_rounded,
        title: 'Trabajo',
        bgColor: AppColors.kRedLight,
        iconColor: AppColors.kRedDark,
        btnColor: AppColors.kRed,
        total: trabajo == null ? 0 : trabajo,
      ),
      Category(
        iconData: Icons.science_rounded,
        title: 'Salud',
        bgColor: AppColors.kGreenLight,
        iconColor: AppColors.kGreenDark,
        btnColor: AppColors.kGreen,
        total: salud == null ? 0 : salud
      ),
      Category(
        iconData: Icons.other_houses_rounded,
        title: 'Otros',
        bgColor: AppColors.kBlueLight,
        iconColor: AppColors.kBlueDark,
        btnColor: AppColors.kBlue,
        total: otros == null ? 0 : otros
      ),
    ];
  }

  List<Category> createCategories() {
    return [
      Category(
        iconData: Icons.person_rounded,
        title: 'Personales',
        bgColor: AppColors.kYellowLight,
        iconColor: AppColors.kYellowDark,
        btnColor: AppColors.kYellow,
      ),
      Category(
        iconData: Icons.cases_rounded,
        title: 'Trabajo',
        bgColor: AppColors.kRedLight,
        iconColor: AppColors.kRedDark,
        btnColor: AppColors.kRed,
      ),
      Category(
          iconData: Icons.science_rounded,
          title: 'Salud',
          bgColor: AppColors.kGreenLight,
          iconColor: AppColors.kGreenDark,
          btnColor: AppColors.kGreen,
      ),
      Category(
          iconData: Icons.other_houses_rounded,
          title: 'Otros',
          bgColor: AppColors.kBlueLight,
          iconColor: AppColors.kBlueDark,
          btnColor: AppColors.kBlue,
      ),
    ];
  }
}