import 'dart:math';
import 'package:flutter/material.dart';
import 'Classes.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: menu(context),
      appBar: AppBar(
        title: const Text("Пользователи"),
      ),
      body: FutureBuilder<List<User>>(
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Произошла ошибка!'),
              );
            } else if (snapshot.hasData) {
              return UserList(users: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({Key? key, required this.users}) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return UserListItem(user: users[index]);
      },
    );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 3.0,
            color: Color.fromARGB(50, 0, 0, 0),
          ),
        ],
      ),
        child: ListTile(
          title: Text('${user.id}. ${user.name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          subtitle: Text(user.email),
          leading: Icon(
            Icons.account_circle_outlined,
            size: 48.0,
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserScreen(
                    user: user,
                  )),
            );
        },
      ),
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: menu(context),
      appBar: AppBar(
        title: Text("${widget.user.name} (${widget.user.username})"),
       ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(
                Icons.account_circle_sharp,
                color: Colors.blue[500],
                size: 120,
              ),
              //const SizedBox(height: 10),
              // Text(
              //   "${widget.user.name} (${widget.user.username})",
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(
              //     fontSize: 25,
              //     shadows: <Shadow>[
              //       Shadow(
              //         offset: Offset(3.0, 3.0),
              //         blurRadius: 3.0,
              //         color: Color.fromARGB(50, 0, 0, 0),
              //       ),
              //     ],
              //   )
              // ),
              const SizedBox(height: 10),
            ListTile(
                iconColor: Colors.indigo,
                leading: const Icon(Icons.numbers),
                title: const Text('ID'),
                subtitle: Text(widget.user.id.toString()),),
              ListTile(
                iconColor: Colors.redAccent,
                leading: const Icon(Icons.phone),
                title: const Text('Телефон'),
                subtitle: Text(widget.user.phone),
              ),
              ListTile(
                iconColor: Colors.blueAccent,
                leading: const Icon(Icons.mail),
                title: const Text('E-mail'),
                subtitle: Text(widget.user.email),
              ),
              ListTile(
                iconColor: Colors.green,
                leading: const Icon(Icons.web),
                title: const Text('Веб-сайт'),
                subtitle: Text(widget.user.website),
              ),
              ListTile(
                iconColor: Colors.orange,
                leading: const Icon(Icons.business),
                title: const Text('Компания'),
                subtitle: Text('${widget.user.company.name}, '
                    '${widget.user.company.catchPhrase}, '
                    '${widget.user.company.bs}'),
              ),
              ListTile(
                iconColor: Colors.deepPurpleAccent,
                leading: const Icon(Icons.contact_mail),
                title: const Text('Адрес'),
                subtitle: Text('${widget.user.address.street}, '
                    '${widget.user.address.suite}, '
                    '${widget.user.address.city}, '
                    '${widget.user.address.zipcode} ('
                    '${widget.user.address.geo.lat}, '
                    '${widget.user.address.geo.lng})'),
              ),
              ListTile(
                focusColor: Colors.blueGrey,
                  tileColor: Colors.cyan[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  iconColor: Colors.pinkAccent,
                  leading: const Icon(Icons.task),
                  title: const Text('Задания'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserTodosWidget(
                              userId: widget.user.id
                          )),
                    );
                  },
                ),

            ],
          ),
        ),
      ),
    );
  }
}

class UserTodosWidget extends StatefulWidget {
  const UserTodosWidget({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  _UserTodosWidgetState createState() => _UserTodosWidgetState();
}

class _UserTodosWidgetState extends State<UserTodosWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: menu(context),
      appBar: AppBar(
        title: const Text("Задания"),
      ),
      body: FutureBuilder<List<Todo>>(
          future: fetchTasksByUserId(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Ошибка!',
                  style: TextStyle(color: Colors.red, fontSize: 50),),
              );
            } else if (snapshot.hasData) {
              return TodoList(todos: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: widget.todos.length,
      itemBuilder: (BuildContext context, int index) {
        return TodoListItem(
          todo: widget.todos[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
      const SizedBox(height: 1,),
    );
  }
}

class TodoListItem extends StatefulWidget {
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white70,
      elevation: 5,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: CheckboxListTile(
        shape: BeveledRectangleBorder(
             borderRadius: BorderRadius.circular(30.0),),
        checkColor: Colors.green,
        activeColor: Colors.green,
        title: Text(widget.todo.title, style: const TextStyle(fontSize: 22, ),),
        value: widget.todo.completed,
        onChanged: (done) {
          setState(() {
            widget.todo.completed = done!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

Widget menu(context) => Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      child: ListView(
          padding: EdgeInsets.zero,
          children: [
           DrawerHeader(
             margin: const EdgeInsets.all(10),
             padding : const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 70),
             decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('Меню',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white)),
            ),
            //Center(child: Text('Меню')),
            ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            title: const Text('Пользователи', style: TextStyle(fontSize: 20),),
            onTap: () {
              Navigator.pushNamed(context, '/users');
             // Navigator.pop(context);
            },
            ),
          const Divider(
            height: 1,
            thickness: 2,
          ),
          ListTile(
            title: const Text('Выйти', style: TextStyle(fontSize: 20),),
            onTap: () {
            Navigator.pushNamed(context, '/');
            },
          ),
            const Divider(
              thickness: 2,
            ),

          ],
      ),
);
