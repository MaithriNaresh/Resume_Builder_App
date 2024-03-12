import 'package:flutter/material.dart';
import 'package:resume_creator_project/final_resume.dart';

void main() {
  runApp(ResumeBuilderApp());
}

class ResumeBuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      _headlineController.clear();// Clear the text field controller
    }
  }



  void _deleteResumeItem(int index) {
    setState(() {
      _resumeItems.removeAt(index);
    });
  }

  void _viewResume(BuildContext context) {
    if (_resumeItems.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Your Resume'),
            content: SingleChildScrollView(
              child: ListBody(
                children: _resumeItems
                    .map((item) => Text(item))
                    .toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Empty Resume'),
            content: Text('Your resume is empty!'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Builder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _headlineController,
              decoration: InputDecoration(
                labelText: 'Enter headline',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Enter resume item',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: _addResumeItem,
                child: Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FinalResume(resumeItem: _resumeItems)));
                },
                child: Text('View Resume'),
              ),
            ],
          ),
          Expanded(
            child: ReorderableListView(
              children: _resumeItems
                  .map((item) => ListTile(
                key: ValueKey(item),
                title: Text(item.split(': ')[0]), // Show only the resume item text
                subtitle: item.contains(': ') ? Text(item.split(': ')[1]) : null,
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
                              decoration: InputDecoration(labelText: "headline"),
                              controller: _headlineController,
                            ),
                          TextField(
                            decoration: InputDecoration(labelText: "resumeItem"),
                            controller: _textFieldController,
                          ),

                        ],),
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
                              String newText = _textFieldController.text.trim();
                              String newHeadline = _headlineController.text.trim();
                              if (newText.isNotEmpty || newHeadline.isNotEmpty) {
                                String updatedItem = newHeadline.isNotEmpty ? "$newText: $newHeadline" : newText;
                                _updateResumeItem(_resumeItems.indexOf(item),newText,newHeadline);
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
}
