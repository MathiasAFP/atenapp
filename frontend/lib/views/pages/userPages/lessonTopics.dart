import 'package:flutter/material.dart';
import 'package:teste/classes/lessonClass.dart';
import 'package:teste/views/pages/userPages/lessonSubTopics.dart';
import 'package:teste/views/pages/userPages/lessonTopics.dart';

LessonClass lessonClassInstance = LessonClass();
bool hasData = false;

class LessonTopic extends StatefulWidget{
  final String subjectName;
  const LessonTopic({Key? key, required this.subjectName}) : super(key: key);
  @override
  State<LessonTopic> createState() => _LessonTopicState();
}

class _LessonTopicState extends State<LessonTopic> {
  @override
  Widget build(BuildContext context) {
    if (hasData) {
            List subjectsList = lessonClassInstance.lessonData["topics"]?["msg"];
            return ListView.builder(
              itemCount: subjectsList.length,
              itemBuilder: (context, index){
                final item = subjectsList[index]['name'];
                return Card(
                  clipBehavior: Clip.hardEdge, 
                  child: InkWell(
                    splashColor: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonSubTopic(topicName: item)),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(item),
                    ),
                  ),
                );
              });
    }
    return(
      FutureBuilder(future: lessonClassInstance.saveTopicData(widget.subjectName), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            hasData=true;
            print(snapshot.data?["topics"]?["msg"]);
            List subjectsList = snapshot.data?["topics"]?["msg"];
            return ListView.builder(
              itemCount: subjectsList.length,
              itemBuilder: (context, index){
                final item = subjectsList[index]['name'];
                return Card(
                  clipBehavior: Clip.hardEdge, 
                  child: InkWell(
                    splashColor: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonSubTopic(topicName: item,)),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(item),
                    ),
                  ),
                );
              });
          }

          return(Image.network("https://static.vecteezy.com/system/resources/thumbnails/024/405/934/small/icon-tech-error-404-icon-isolated-png.png"));
        }
      )
    );
  }
}