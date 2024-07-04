import 'package:flutter/material.dart';
import 'package:teste_jsonlista/routes/app_routes.dart';
import 'package:teste_jsonlista/user_edit.dart';
import 'package:teste_jsonlista/user_form.dart';
import 'package:teste_jsonlista/view/user_listtile.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      home:  const UserList(),
      routes: {AppRoutes.USER_FORM: (_) => const UserForm(),
      AppRoutes.USER_EDIT: (_) => const UserEdit()},
      debugShowCheckedModeBanner: false,
      );
  }
}

