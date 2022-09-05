import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class MainApp extends StatefulWidget {
  final String username;
  const MainApp({Key? key, required this.username}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int trial = 0;
  int trialLimit = 5;

  final answer = TextEditingController();
  bool isClear() => answer.text.isEmpty;
  static int random(min, max) => min + Random().nextInt((max + 1) - min);
  int secretNumber = random(1, 10);

  @override
  void dispose() {
    answer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Guess Your Number")),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                  child: Text(
                    "Hello, ${widget.username} choose a number between 1 to 10, you can only guess 5 times",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 250,
                  child: Image.asset("images/quiz.png"),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.question_mark),
                    labelText: "Guess the number",
                    labelStyle: TextStyle(fontSize: 20),
                    hintText: "Input your guessed number",
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: answer,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: guess,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Guess",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void alert(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  void guess() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (isClear()) {
      alert("Message", "You must enter the number");
      return;
    }

    int guess = int.parse(answer.text);

    if (guess < 1 || guess > 10) {
      alert("Message", "You must choose number between 1 to 10");
      answer.clear();
      return;
    }

    trial++;
    if (guess != secretNumber && trialLimit == trial) {
      alert("Message",
          "Sorry !!!, You lose\n Your Trial : $trial\n Your Number : $secretNumber\n Let's Try Again");
      trial = 0;
      secretNumber = random(1, 10);
      answer.clear();
      return;
    }

    if (guess == secretNumber) {
      alert("Message",
          "Congratulations, your guess number is right!\n Your Trial : $trial");
      secretNumber = random(1, 10);
      trial = 0;
    } else {
      guess < secretNumber
          ? alert("Message", "your guess is too small\n Your Trial : $trial")
          : alert("Message", "your guess is too large\n Your Trial : $trial");
    }
    answer.clear();
  }
}
