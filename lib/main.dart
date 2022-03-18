import 'package:flutter/material.dart';
import 'QuizBrain.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: quiz(),
    );
  }
}

class quiz extends StatefulWidget {
  @override
  _quizState createState() => _quizState();
}

QuizBrain myQuiz = QuizBrain();
List<Icon> scoreKeepr = [];

class _quizState extends State<quiz> {
  void answer(bool sent) {
    if (sent == myQuiz.getQuestion().answer) {
      showRes(true);
    } else {
      showRes(false);
    }
    myQuiz.nextQuestion();
  }

  void showRes(bool res) {
    switch (res) {
      case true:
        scoreKeepr.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        break;
      default:
        scoreKeepr.add(Icon(Icons.close, color: Colors.red));
    }
    if (scoreKeepr.length == myQuiz.retLength()) {
      AlertDialog alert = AlertDialog(
        title: Text('Finished!'),
        content: Text('You have reached the end of the quiz.'),
        actions: [
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                scoreKeepr.clear();
                myQuiz.resetQuestions();
                Navigator.pop(context);
              });
            },
            child: Text('Cancel'),
          )
        ],
        elevation: 24.0,
        backgroundColor: Colors.white,
      );
      showDialog(
        context: context,
        builder: (_) => alert,
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    myQuiz.getQuestion().question,
                    style: TextStyle(
                      // fontFamily: 'Roboto',
                      fontSize: 20.0,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              flex: 3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      answer(true);
                    });
                  },
                  color: Colors.green,
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FlatButton(
                  onPressed: () {
                    setState(
                      () {
                        answer(false);
                      },
                    );
                  },
                  color: Colors.red,
                  child: Text(
                    'False',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: scoreKeepr,
            ),
          ],
        ),
      ),
    );
  }
}
