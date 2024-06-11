import 'package:crud_2/provider/users.dart';
import 'package:crud_2/routes/app_routes.dart';
import 'package:crud_2/views/user_form.dart';
import 'package:crud_2/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const UserList(),
        routes: {AppRoutes.USER_FORM: (_) => UserForm()},
      ),
    );
  }
}
