import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User ({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      address: Address.fromJson(json['address']),
      phone: json['phone'] as String,
      website: json['website'] as String,
      company: Company.fromJson(json['company']),
    );
  }
}

Future<List<User>> fetchUsers() async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Не удалось получить список пользователей!');
  }
}
class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final AddressGeo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
      geo: AddressGeo.fromJson(json['geo']),
    );
  }
}
class AddressGeo {
  final String lat;
  final String lng;

  AddressGeo({
    required this.lat,
    required this.lng
  });

  factory AddressGeo.fromJson(Map<String, dynamic> json) {
    return AddressGeo(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String,
      catchPhrase: json['catchPhrase'] as String,
      bs: json['bs'] as String,
    );
  }
}

class Todo {
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed
  });
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}
const todoAddress =
    'https://jsonplaceholder.typicode.com/todos?userId='; //константа адреса без Айди
Future<List<Todo>> fetchTasksByUserId(int userId) async {
  final response = await http.get(
      Uri.parse(todoAddress+'$userId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
  } else {
    throw Exception('Не удалось получить информацию о пользователе!');
  }
}


