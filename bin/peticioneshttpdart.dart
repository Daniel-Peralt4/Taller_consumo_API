import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

void main() async {
  // URL de la API
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  // Realizar la petición GET
  final response = await http.get(url);

  // Verificar si la petición fue exitosa
  if (response.statusCode == 200) {
    // Parsear la respuesta JSON a una lista
    List<dynamic> jsonData = json.decode(response.body);

    // Crear una lista de Users
    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    // Mostrar los datos
    users.forEach((user) {
      print('ID: ${user.id}');
      print('Name: ${user.name}');
      print('Username: ${user.username}');
      print('Email: ${user.email}');
      print('---');
    });

    usuariosPorUsername(users);
    usuariosConDominioBiz(users);
  } else {
    // Manejo de errores
    print('Error al obtener los datos: ${response.statusCode}');
  }
}

void usuariosPorUsername(List<User> users) {
  print('***');
  print("Usuarios con username de más de 6 caracteres");
  users.where((user) => user.username.length > 6).forEach((user) {
    print('ID: ${user.id}');
    print('UserName: ${user.username}');
    print('---');
  });
}

void usuariosConDominioBiz(List<User> users) {
  print('***');
  print("Usuarios con dominio de correo electrónico @biz");
  int numUsuarios = users.where((user) => user.email.contains('biz')).length;
  print(
      'El número de usuarios con dominio de correo electrónico @biz es: $numUsuarios');
}
