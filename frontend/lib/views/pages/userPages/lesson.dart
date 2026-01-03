import 'package:flutter/material.dart';
import 'package:teste/classes/lessonClass.dart';
import 'package:teste/views/pages/userPages/lessonTopics.dart';

LessonClass lessonClassInstance = LessonClass();
bool hasData = false;

class Lesson extends StatefulWidget{
  final String subTopicName;
  const Lesson({Key? key, required this.subTopicName}) : super(key: key);
  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(widget.subTopicName)));
  }
}