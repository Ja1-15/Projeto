import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teste_jsonlista/post.dart';
import 'package:http/http.dart' as http;
import 'package:teste_jsonlista/view/user_listtile.dart';

class UserEdit extends StatefulWidget {

  const UserEdit({super.key});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(Post? user) {
    if(user != null){
    _formData['id'] = user.id!.toString();
    _formData['telefone'] = user.telefone!;
    _formData['nome'] = user.nome!;
    _formData['email'] = user.email!;
    }
  }
  TextEditingController controller_nome = TextEditingController();
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_telefone = TextEditingController();

   update(){
    setState(() {
     controller_nome.text;
     controller_email.text;
     controller_telefone.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Post? user = ModalRoute.of(context)!.settings.arguments as Post?;
    _loadFormData(user);
    controller_nome.value = TextEditingValue(text : _formData["nome"]!);
    controller_email.value = TextEditingValue(text: _formData["email"]!);
    controller_telefone.value = TextEditingValue(text: _formData["telefone"]!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                updatelist(_formData);
                _form.currentState?.save();
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const UserList()))
                  .then((value) => setState(() {}));
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
                  controller: controller_nome,
                  onChanged: (val){
                    controller_nome.text = val;
                  },
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
                  controller: controller_email,
                  onChanged: (val){
                    controller_email.text = val;
                  },
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _formData['email'] = value!,
                ),
                TextFormField(
                  controller: controller_telefone,
                  onChanged: (val){
                    controller_telefone.text = val;
                  },
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  onSaved: (value) => _formData['telefone'] = value!,
                )
              ],
            )),
      ),
    );
  }

Future updatelist(_formData) async{
    final id = _formData["id"];
     await http.put(Uri.parse("http://154.12.241.153:28888/customers/$id"),
    headers: <String, String>{
      'Content-type' : 'application/json; charset=UTF-8'
    },
    body: jsonEncode({
    "id" : _formData["id"],
    "nome" : controller_nome.text,
    "email" : controller_email.text,
    "telefone" : controller_telefone.text
    }));
    }
}