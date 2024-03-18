import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resume_creator_project/final_resume.dart';
import 'package:resume_creator_project/ui_builder.dart';

void main() {
  runApp(ResumeBuilderApp());
}

class ResumeBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResumeBuilderScreen(),
    );
  }
}

class ResumeBuilderScreen extends StatefulWidget {
  @override
  _ResumeBuilderScreenState createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  List<String> _resumeItems = [];
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _headlineController = TextEditingController();

  void _addResumeItem() {
    String newItem = _textFieldController.text.trim();
    String hedlineItem = _headlineController.text.trim();
    if (newItem.isNotEmpty) {
      setState(() {
        _resumeItems.add("$hedlineItem : $newItem");
      });
      _textFieldController.clear();
      _headlineController.clear();
    }
  }

  void _updateResumeItem(int index, String newText, String newHeadline) {
    if (newText.isNotEmpty) {
      setState(() {
        if (newHeadline.isNotEmpty) {
          _resumeItems[index] = "$newHeadline: $newText";
        } else {
          _resumeItems[index] = newText;
        }
      });
      _textFieldController.clear();
      _headlineController.clear(); // Clear the text field controller
    }
  }

  void _deleteResumeItem(int index) {
    setState(() {
      _resumeItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiBuilder.buildAppBar("Resume Builder"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          customContainer(_headlineController, 'Enter headLine'),
         customContainer(_textFieldController, 'EnterResumeItem'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child:
                      UiBuilder.customButton((){
                        if(_headlineController.text.isNotEmpty && _textFieldController.text.isNotEmpty ){
                          print("Add Item");
                          _addResumeItem();

                        }else{
                          UiBuilder.customAlertBox(context, "Fill The Required Fields");
                        }

                      }, 'Add', Icons.add),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: UiBuilder.customButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FinalResume(resumeItem: _resumeItems)));
                  }, 'View Resume', Icons.visibility),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView(
              children: _resumeItems
                  .map((item) => ListTile(
                        key: ValueKey(item),
                        title: Text(item.split(': ')[0]),
                        // Show only the resume item text
                        subtitle: item.contains(': ')
                            ? Text(item.split(': ')[1])
                            : null,
                        // leading: Icon(Icons.drag_handle),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Item'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: const InputDecoration(
                                          labelText: "headline"),
                                      controller: _headlineController,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                          labelText: "resumeItem"),
                                      controller: _textFieldController,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Update'),
                                    onPressed: () {
                                      String newText =
                                          _textFieldController.text.trim();
                                      String newHeadline =
                                          _headlineController.text.trim();
                                      if (newText.isNotEmpty ||
                                          newHeadline.isNotEmpty) {
                                        String updatedItem =
                                            newHeadline.isNotEmpty
                                                ? "$newText: $newHeadline"
                                                : newText;
                                        _updateResumeItem(
                                            _resumeItems.indexOf(item),
                                            newText,
                                            newHeadline);
                                      }

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteResumeItem(_resumeItems.indexOf(item));
                          },
                        ),
                      ))
                  .toList(),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  String item = _resumeItems.removeAt(oldIndex);
                  _resumeItems.insert(newIndex, item);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  customContainer(TextEditingController controller, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.all(10),
      decoration:
          BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5), boxShadow: [
        BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.grey.shade100)
      ]),
      child: TextField(
        controller: controller,
        decoration:  InputDecoration(
          border: InputBorder.none,
          labelText: title,
        ),
      ),
    );
  }
}
