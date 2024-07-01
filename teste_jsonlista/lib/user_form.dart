import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:teste_jsonlista/post.dart';
import 'package:http/http.dart' as http;

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  UserForm({super.key});

  void _loadFormData(Post? user) {
    if(user != null){
    _formData['id'] = user.id!.toString();
    _formData['telefone'] = user.telefone!;
    _formData['nome'] = user.nome!;
    _formData['email'] = user.email!;
    }
  }
  @override
  Widget build(BuildContext context) {
    final Post? user = ModalRoute.of(context)!.settings.arguments as Post?;
    _loadFormData(user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                updatelist();
                _form.currentState?.save();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _formData['nome'],
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nome Inválido';
                    }
                    if (value.trim().length < 3) {
                      return 'Nome muito pequeno';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['nome'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _formData['email'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['telefone'],
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  onSaved: (value) => _formData['telefone'] = value!,
                )
              ],
            )),
      ),
    );
  }

Future updatelist() async{
  final dio = Dio();
  if(_formData.isEmpty == true ){
  return await dio.post("http://154.12.241.153:28888/customers", data: {
    'id' : _formData["id"],
    'email' : _formData["email"],
    'nome' : _formData["nome"],
    'telefone' : _formData["telefone"]
  });
  }
  else{
    final id = _formData["id"];
    return await dio.put("http://154.12.241.153:28888/customers?$id", data: {
    'email' : _formData["email"],
    'nome' : _formData["nome"],
    'telefone' : _formData["telefone"]
    });
  }
}
}
