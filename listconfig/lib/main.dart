import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> items = [
    "Dart",
    "Python",
    "Flutter",
    "Kotlin",
    "Swift",
    "JavaScript",
    "C"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
      centerTitle: true,
      title: const Text("Teste"),),
    
    body: ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index){
        return Dismissible(
          onDismissed: (direction){
            setState((){
              items.removeAt(index);
            });
          },
          confirmDismiss: (DismissDirection direction) async{
            if(direction == DismissDirection.startToEnd){
              return await showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text("Delete"),
                    content: const Text("Are you sure you want to delete this item?"), 
                    actions: <Widget>[
                      ElevatedButton(onPressed: () => Navigator.of(context).pop(true),
                       child: const Text("Yes")),
                       ElevatedButton(onPressed: () => Navigator.of(context).pop(false), 
                       child: const Text("No"))
                    ],
                  );

                });
            }
            else{
              return await showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: const Text("Save"),
                      content: const Text("Are you sure you want to edit this item?"),
                      actions: <Widget>[
                        ElevatedButton(onPressed: () => Navigator.of(context).pop(true),
                         child: const Text("Yes")),
                         ElevatedButton(onPressed: () => Navigator.of(context).pop(false), 
                         child: const Text("No"))
                      ],
                  );

                });
            }
          },
          background: Container(
            height: 50,
            color: Colors.red,
            margin: const EdgeInsets.only(top: 10),
            child: const Padding(padding: const EdgeInsets.all(8),
            child: const Text("Delete", textAlign: TextAlign.left,),),

          ),
          secondaryBackground: Container(
            height: 50,
            color: Colors.orange[400],
            margin: const EdgeInsets.only(top: 10),
            child: const Padding(padding: const EdgeInsets.all(8),
            child: const Text("Edit", textAlign: TextAlign.right,),),
          ),
          key: ValueKey<String>(items[index]),
          child: Container(
            color: const Color(0xffEBEDFE),
            margin: const EdgeInsets.only(top: 10),
            height: 50,
            child: Center(
              child: Text(items[index]),
            ),
          )
          );
      }) ,
    );
  }
  
  }