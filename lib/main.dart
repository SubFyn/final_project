import 'package:final_project/Users.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _title = 'Заголовок приложения';
    return GestureDetector(
      onTap: () {FocusManager.instance.primaryFocus?.unfocus();},
      child: MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(_title),
          ),
          body: const AuthPage(),
        ),
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Авторизация',
            style: TextStyle(color: Colors.black, fontSize: 30,),),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextFormField(
              decoration: InputDecoration (
                alignLabelWithHint: false,
                prefixIcon: const Icon(Icons.person_pin, size: 40, color: Colors.blue,),
                hintText: 'Введите Ваш логин',
                labelText: 'Логин',
                labelStyle: const TextStyle(fontSize: 20, color: Colors.blue),
                enabledBorder: lightBlueBorder,
                focusedBorder: blueBorder,
              ),
              textAlign: TextAlign.center,
              controller: loginController,
              validator: (login) {
                if (login == null || login.isEmpty) {
                  return 'Пожалуйста, введите логин';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration (
                alignLabelWithHint: false,
                prefixIcon: const Icon(Icons.lock, size: 40, color: Colors.blue,),
                hintText: 'Введите Ваш пароль',
                labelText: 'Пароль',
                labelStyle: const TextStyle(fontSize: 20, color: Colors.blue),
                enabledBorder: lightBlueBorder,
                focusedBorder: blueBorder,
              ),
              textAlign: TextAlign.center,
              obscureText: true,
              controller: passController,
              validator: (pass) {
                if (pass == null || pass.isEmpty) {
                  return 'Пожалуйста, введите пароль';
                }
                return null;
              },
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
                      const SnackBar(content: Text('Успешный вход',
                        style: TextStyle(color: Colors.green, fontSize: 20),)));
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserScreen()),
                      );
                }
                else {ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Неверный логин или пароль',
                      style: TextStyle(color: Colors.red, fontSize: 20),)));
                }},
                child: const Text('Войти', style: TextStyle(fontSize: 20),),),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MyApp());