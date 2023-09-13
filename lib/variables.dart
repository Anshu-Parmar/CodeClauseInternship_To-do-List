import 'package:flutter/cupertino.dart';

class SaveValues{
  static int? id;
  List<Map<String, dynamic>> journals = [];
  static TextEditingController titleController1 = TextEditingController();
  TextEditingController titleController = TextEditingController();

  static TextEditingController descriptionController1 = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void setValues(int? idd, String titleC, String descC){setVals(idd, titleC, descC);}
  //void setValue(int? idd){setVal(idd);}

  static setVals(int? idd, String titleC, String descC){
    id =idd;
      titleController1.text = titleC;
      descriptionController1.text = descC;

  }
  String getTitleController(){
    return titleController1.text;
  }
  String getDescriptionController(){
    return descriptionController1.text;
  }

  int? getVal() {
    return id;
  }
}