import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teste_jsonlista/post.dart';
import 'package:http/http.dart' as http;
import 'package:teste_jsonlista/view/user_listtile.dart';

class UserForm extends StatefulWidget {

  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final TextEditingController controller_email = TextEditingController();
  final TextEditingController controller_nome = TextEditingController();
  final TextEditingController controller_telefone = TextEditingController();
  final Map<String, String> _formData = {};

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
                postlist(_formData);
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
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _formData['email'] = value!,
                ),
                TextFormField(
                  controller: controller_telefone,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  onSaved: (value) => _formData['telefone'] = value!,
                )
              ],
            )),
      ),
    );
  }

Future postlist(formData) async{
  if(formData["id"] == null ){
  final response = await http.post(Uri.parse("SUA_API"),
  headers: <String, String>{
    'Content-type' : 'application/json; charset=UTF-8'
  },
  body: jsonEncode(
    {
    "nome" : controller_nome.text,
    "email" : controller_email.text,
    "telefone" : controller_telefone.text
    }
    )
  );

  return ( response.statusCode == 200 );
  
}
  
}
}
