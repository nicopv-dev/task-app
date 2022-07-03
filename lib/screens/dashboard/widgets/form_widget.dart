import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/services/category_service.dart';

import '../../../models/category.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidget createState() => _FormWidget();
}

class _FormWidget extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  CategoryService _categoryService = CategoryService();
  var title = "";
  String? selectedCategory = "";


  @override
  Widget build(BuildContext context) {
    List<Category> categories = _categoryService.createCategories();
    User currentUser = FirebaseAuth.instance.currentUser!;

    return Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.task_outlined, color: Colors.greenAccent,),
                  hintText: "¿Cual es el titulo de la tarea?",
                  labelText: "Titulo de la tarea",
                  hoverColor: Colors.grey,
                  hintStyle: TextStyle(color: Colors.grey),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent)),
                ),
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Por favor ingresa nonbre a la tarea";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              Text("Seleccione Categoria", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              GridView.builder(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                ),
                itemBuilder: (context, index) => _buildCategory(context, categories[index]),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection("tasks").add({
                      'title': title,
                      'category': selectedCategory,
                      'date': DateTime.now().toString(),
                      'uid': currentUser.uid,
                    }).then((value) => {
                      Navigator.of(context).pop()
                    }).catchError((e) => {

                    });
                  },
                  label: Text("Crear tarea", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  icon: Icon(Icons.add, size: 30,),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _buildCategory(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category.title;
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: selectedCategory == category.title ? category.bgColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.iconData, color: selectedCategory == category.title ? category.iconColor : Colors.grey, size: 35,),
            SizedBox(height: 10,),
            Text(category.title!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
