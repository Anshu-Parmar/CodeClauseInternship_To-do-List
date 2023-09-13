import 'package:flutter/material.dart';
import 'package:todolist/add_new_entry.dart';
import 'package:todolist/sql_components/sql_helper.dart';
import 'package:todolist/theme/theme_constant.dart';
import 'package:todolist/theme/theme_manager.dart';
import 'package:todolist/variables.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To-do List",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const MainScreen(),

    );
  }
}

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //List<Map<String, dynamic>> sv.journals = [];
  SaveValues sv = SaveValues();

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }
  

  void _refreshJournals() async{
    final data = await SQLHelper.getItems();
    setState(() {
      sv.journals = data;
    });
  }

  Future<void> _deleteItem(int id) async{
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a entry!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        backgroundColor: Colors.orange,
        child: Icon(Icons.add,
          color: isDark? Colors.white:Colors.black,
        ),
        onPressed: (){
          // _showForm(null);
          sv.setValues(null, '', '');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewEntry())).then((value) => _refreshJournals());
        }
      ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("To-do List",
                      style: _textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    Switch(
                        value: _themeManager.themeMode == ThemeMode.dark,
                        onChanged: (newVal){
                          _themeManager.toggleTheme(newVal);
                        }
                      )
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sv.journals.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: ListTile(
                          title: Text(sv.journals[index]['title'],
                          style: const TextStyle(color: Colors.black,),),
                          subtitle: Text(sv.journals[index]['description'],
                            style: const TextStyle(color: Colors.black,),),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: (){
                                      int? tempId = sv.journals[index]['id'];
                                      if (tempId!=null){
                                        final existingJournal = sv.journals.firstWhere((element) => element['id'] == tempId);
                                        sv.titleController.text = existingJournal['title'];
                                        sv.descriptionController.text = existingJournal['description'];
                                      }
                                      sv.setValues(sv.journals[index]['id'], sv.titleController.text, sv.descriptionController.text);

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewEntry())).then((value) => _refreshJournals());
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.black,)
                                ),
                                IconButton(
                                    onPressed: ()=> _deleteItem(sv.journals[index]['id']),
                                    icon: const Icon(Icons.delete, color: Colors.black,)
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}

