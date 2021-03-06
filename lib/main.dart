import 'dart:math';
import 'package:final_project/Users.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {FocusManager.instance.primaryFocus?.unfocus();},
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthPage(),
          '/users': (context) => const UsersScreen(),
        },
      ),
    );  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  var loginController = TextEditingController();
  var passController = TextEditingController();
  final lightBlueBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(width: 1, color: Colors.lightBlue),);
  final blueBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(width: 1, color: Colors.blue),);

  @override
  Widget build(BuildContext context) {
    return Scaffold( //color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            const Alignment(0.8, 0.0),
            colors: <Color>[
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
              Colors.primaries[Random().nextInt(Colors.primaries.length)]
            ],
           ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                color: Colors.blue[500],
                size: 150,
              ),
              const Text('??????????????????????',
                style: TextStyle(color: Colors.blue, fontSize: 30,
                    fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextFormField(
                    decoration:
                    InputDecoration (
                    alignLabelWithHint: false,
                      prefixIcon: const Icon(Icons.person_pin, size: 40, color: Colors.blue,),
                      hintText: '?????????????? ?????? ??????????',
                      labelText: '??????????',
                      labelStyle: const TextStyle(fontSize: 20, color: Colors.blue),
                      enabledBorder: lightBlueBorder,
                      focusedBorder: blueBorder,
                    ),
                    textAlign: TextAlign.center,
                    controller: loginController,
                    validator: (login) {
                      if (login == null || login.isEmpty) {
                        return '????????????????????, ?????????????? ??????????';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration (
                      alignLabelWithHint: false,
                      prefixIcon: const Icon(Icons.lock, size: 40, color: Colors.blue,),
                      hintText: '?????????????? ?????? ????????????',
                      labelText: '????????????',
                      labelStyle: const TextStyle(fontSize: 20, color: Colors.blue),
                      enabledBorder: lightBlueBorder,
                      focusedBorder: blueBorder,
                    ),
                    textAlign: TextAlign.center,
                    obscureText: true,
                    controller: passController,
                    validator: (pass) {
                      if (pass == null || pass.isEmpty) {
                        return '????????????????????, ?????????????? ????????????';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox( width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),)
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          loginController.text == "tester" &&
                          passController.text == "test12345")
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('???????????????? ????????',
                              style: TextStyle(color: Colors.green, fontSize: 20),)));
                        Navigator.pushNamed(context, '/users');
                      }
                      else {ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('???????????????? ?????????? ?????? ????????????',
                                style: TextStyle(color: Colors.red, fontSize: 20),)));
                      }},
                    child: const Text('??????????', style: TextStyle(fontSize: 20),),),
                ),
              ),
            ],
          ),
        ),
      ),);
  }
}

void main() => runApp(const MyApp());