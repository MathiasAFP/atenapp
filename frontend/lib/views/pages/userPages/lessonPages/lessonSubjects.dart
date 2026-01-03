import 'package:flutter/material.dart';
import 'package:teste/classes/lessonClass.dart';
import 'package:teste/views/pages/userPages/lessonPages/lessonTopics.dart';

LessonClass lessonClassInstance = LessonClass();
bool hasData = false;

class LessonSubjects extends StatefulWidget{
  @override
  State<LessonSubjects> createState() => _LessonSubjectsState();
}

class _LessonSubjectsState extends State<LessonSubjects> {
  @override
  Widget build(BuildContext context) {
    if (hasData) {
            List subjectsList = lessonClassInstance.lessonData["subjects"]["msg"];
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
                        MaterialPageRoute(builder: (context) => LessonTopic(subjectName: item)),
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
      FutureBuilder(future: lessonClassInstance.saveSubjectData(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            hasData=true;
            List subjectsList = snapshot.data?["subjects"]["msg"];
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
                        MaterialPageRoute(builder: (context) => LessonTopic(subjectName: item)),
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