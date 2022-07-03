import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/utils/app_colors.dart';

class Category {
  IconData? iconData;
  String? title;
  Color? bgColor;
  Color? iconColor;
  Color? btnColor;
  num? total;
  num? left;
  num? done;
  List<Task>? tasks;

  bool isLast;

  Category({this.iconData, this.title, this.bgColor, this.iconColor, this.btnColor, this.total, this.left, this.done, this.tasks, this.isLast = false});

  static List<Category> generateCategories() {
    return [
      Category(
        iconData: Icons.person_rounded,
        title: 'Personales',
        bgColor: AppColors.kYellowLight,
        iconColor: AppColors.kYellowDark,
        btnColor: AppColors.kYellow,
        total: 4,
        left: 3,
        done: 1,
      ),
      Category(
        iconData: Icons.cases_rounded,
        title: 'Trabajo',
        bgColor: AppColors.kRedLight,
        iconColor: AppColors.kRedDark,
        btnColor: AppColors.kRed,
        total: 0,
        left: 0,
        done: 0,
      ),
      Category(
        iconData: Icons.science_rounded,
        title: 'Salud',
        bgColor: AppColors.kGreenLight,
        iconColor: AppColors.kGreenDark,
        btnColor: AppColors.kGreen,
        total: 0,
        left: 0,
        done: 0,
      ),
      Category(
        iconData: Icons.other_houses_rounded,
        title: 'Otros',
        bgColor: AppColors.kBlueLight,
        iconColor: AppColors.kBlueDark,
        btnColor: AppColors.kBlue,
        total: 0,
        left: 0,
        done: 0,
      ),
    ];
  }
}