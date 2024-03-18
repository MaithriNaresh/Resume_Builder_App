import 'package:flutter/material.dart';
import 'package:resume_creator_project/ui_builder.dart';

import 'main.dart';

class FinalResume extends StatelessWidget {
  final List<String> resumeItem;
  FinalResume({Key? key , required this.resumeItem }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResumeBuilderScreen? resumeBuilderScreen;
    return  Scaffold(
      appBar:UiBuilder.buildAppBar("Final Resume"),
      body:  resumeItem.isNotEmpty ?  SingleChildScrollView(
        child: ListBody(
          children: resumeItem
              .map((item) => Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            margin: EdgeInsets.only(top: 20,left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
              Text("${item.split(':')[0]}:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              Text(  item.split(':')[1]),

            ],),
          ))
              .toList(),
        ),
      ) :
          const Center(child: Text("Your Resume is Empty",style: TextStyle(fontSize: 20),),)
    );
  }
}
