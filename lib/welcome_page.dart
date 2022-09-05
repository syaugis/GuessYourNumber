import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guessyournumber/main_app.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "Welcome to The Guess Your Number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: Image.asset("images/welcome.png"),
            ),
            const UsernameForm(),
          ],
        ),
      ),
    );
  }
}

class UsernameForm extends StatefulWidget {
  const UsernameForm({super.key});

  @override
  State<UsernameForm> createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  final username = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void deleteText() {
    username.clear();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return;
  }

  @override
  void dispose() {
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'You Must Enter Your Name !!!';
                }
                return null;
              },
              cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
              maxLength: 25,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Please Enter Your Name",
                border: const OutlineInputBorder(),
                icon: const Icon(Icons.person_outline),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.cancel,
                  ),
                  onPressed: deleteText,
                ),
              ),
              controller: username,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
            child: ElevatedButton.icon(
                label: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18),
                ),
                icon: const Icon(
                  Icons.send,
                  size: 20,
                ),
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                    (Set<MaterialState> states) {
                      return const EdgeInsets.all(15);
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MainApp(
                          username: username.text,
                        );
                      }),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
