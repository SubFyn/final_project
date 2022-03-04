import 'dart:async';
import 'package:flutter/material.dart';
import 'package:final_project/Classes.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  late Future<User> futureUser;

  @override
  void initState(){
    super.initState();
    futureUser = fetchUsers() as Future<User>;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заголовок второй страницы',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Пользователи'),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    const Text('ID:', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${snapshot.data!.id}'),
                    const SizedBox(height: 10,),
                    const Text('Name:', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${snapshot.data!.name}'),
                    const SizedBox(height: 10,),
                    const Text('Email:', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${snapshot.data!.email}'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
