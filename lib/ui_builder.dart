import 'package:flutter/material.dart';

class UiBuilder {

  static const Color primaryWhite = Colors.white;

  static LinearGradient color() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        const Color(0xff0ef6e8),
        Colors.indigo.shade700,
      ],
    );
  }

  static InkWell customButton(Function()? callBack, String title,
      IconData icon) {
    return InkWell(
      onTap: callBack,
      child: Container(
        // margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0Xff0868c2)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.only(right: 10),
                child: Icon(icon, color: Colors.white,),
              ),
              Text(title, style: const TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),)
            ],)
      ),
    );
  }

  static Text headingText(String title) {
    return Text(
      title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),);
  }

  static Text contentText(String title) {
    return Text(title, style: const TextStyle(fontSize: 15,));
  }

  static customAlertBox(BuildContext context, String title) {
    return showDialog(context: context, builder: (_) {
      return AlertDialog(
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(title),
      );
    });
  }

  static buildLine() {
    return Container(
      color: Colors.black,
      height: 1,
      width: double.infinity,
      // margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
  static  spacer(double size) {
    return SizedBox(
      height: size,
    );
  }
  static AppBar buildAppBar(String title, ){
      return AppBar(
        flexibleSpace: Container(decoration: BoxDecoration(gradient: UiBuilder.color()),),
        title: Text(title,style:  const TextStyle(color: Colors.white),),
      );
  }
}