import 'package:flutter/material.dart';
import 'package:teste/classes/lessonClass.dart';
import 'package:teste/views/pages/userPages/lessonPages/lesson.dart';
import 'package:teste/views/pages/userPages/lessonPages/lessonTopics.dart';

LessonClass lessonClassInstance = LessonClass();
bool hasData = false;

class LessonSubTopic extends StatefulWidget{
  final String topicName;
  const LessonSubTopic({Key? key, required this.topicName}) : super(key: key);
  @override
  State<LessonSubTopic> createState() => _LessonSubTopicState();
}

class _LessonSubTopicState extends State<LessonSubTopic> {
  @override
  Widget build(BuildContext context) {
    if (hasData) {
            List subjectsList = lessonClassInstance.lessonData["subTopics"]?["msg"];
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
                        MaterialPageRoute(builder: (context) => Lesson(subTopicName: item)),
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
      FutureBuilder(future: lessonClassInstance.saveSubTopicData(widget.topicName), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            hasData=true;
            List subjectsList = snapshot.data?["subTopics"]?["msg"];
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
                        MaterialPageRoute(builder: (context) => Lesson(subTopicName: item)),
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