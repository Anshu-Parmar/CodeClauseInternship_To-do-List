import 'package:flutter/material.dart';
import 'package:todolist/sql_components/sql_helper.dart';
import 'package:todolist/variables.dart';

class AddNewEntry extends StatefulWidget {
  const AddNewEntry({super.key});

  @override
  State<AddNewEntry> createState() => _AddNewEntryState();
}

class _AddNewEntryState extends State<AddNewEntry> {
  @override
  Widget build(BuildContext context) {
    final SaveValues sv = SaveValues();
    TextTheme textTheme = Theme.of(context).textTheme;
    int? id = sv.getVal();

    Future<void> _addItem() async{
      await SQLHelper.createItem(
          sv.titleController.text, sv.descriptionController.text);
    }

    Future<void> _updateItem(int idd) async{

      await SQLHelper.updateItem(
          idd,
          sv.titleController.text,
          sv.descriptionController.text
      );
    }
    sv.titleController.text =  sv.getTitleController();
    sv.descriptionController.text = sv.getDescriptionController();
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.orange,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New Entry...",
                      style: textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: sv.titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                    style: TextStyle(color: isDark?Colors.white:Colors.black),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: sv.descriptionController ,
                    decoration: const InputDecoration(hintText: 'Description'),
                    style: TextStyle(color: isDark?Colors.white:Colors.black),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () async {
                        if(id == null){
                          await _addItem();
                        }
                        if(id != null){
                          await _updateItem(id);
                        }
                        sv.titleController.text = '';
                        sv.descriptionController.text = '';
                        Navigator.of(context).pop();

                      },
                      child: Text(id == null ? 'Create New' : 'Update', style: const TextStyle(color: Colors.black,),))
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
