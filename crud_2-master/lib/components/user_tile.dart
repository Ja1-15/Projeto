import 'package:crud_2/models/user.dart';
import 'package:crud_2/provider/users.dart';
import 'package:crud_2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.USER_FORM, arguments: user);
                }),
            IconButton(
                icon: const Icon(Icons.delete), color: Colors.red, onPressed: () {
                  showDialog(context: context, builder: (ctx) => AlertDialog(
                    title: Text("Excluir Usuário"),
                    content: Text("Tem certeza?"),
                    actions: <Widget>[
                      TextButton(child: Text("Não"), onPressed: () {Navigator.of(context).pop();}, ),
                      TextButton( child: Text("Sim"), onPressed: () {Provider.of<Users>(context, listen: false).remove(user);
                       Navigator.of(context).pop();},)
                    ],
                  ));
                })
          ],
        ),
      ),
    );
  }
}
