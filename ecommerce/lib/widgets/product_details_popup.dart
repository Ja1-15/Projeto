import 'package:ecommerce/widgets/container_button_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsPopup extends StatefulWidget {

  @override
  State<ProductDetailsPopup> createState() => _ProductDetailsPopupState();
}

class _ProductDetailsPopupState extends State<ProductDetailsPopup> {
  final iStyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    fontSize: 18
  );

  int counter = 1;

  List<Color> clrs = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.amber
  ];

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
            ),
          ),
          child: Padding(
           padding: EdgeInsets.all(30),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Size: ", style: iStyle,),
                    SizedBox(height: 20,),
                    Text("Color: ", style: iStyle,),
                    SizedBox(height: 30,),
                  ],
                ),
                SizedBox(width:  10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text("S", style: iStyle,),
                      SizedBox(width: 30,),
                      Text("M", style: iStyle,),
                      SizedBox(width: 30,),
                      Text("L", style: iStyle,),
                      SizedBox(width: 30,),
                      Text("XL", style: iStyle,),
                      SizedBox(width: 30,),                    
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      children: [
                        for(var i=0; i<4; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            color: clrs[i],
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),

                  InkWell(
                    onTap: (){

                    },
                    child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 65),
                      maximumSize: Size(200, 65),
                      backgroundColor: Color(0xFFEF6969),
                     ),
                    child: Text("Adicionar ao carrinho",
                    style: TextStyle(
                      color: Colors.white
                    ),),
                    )
                  )
                  
                ],
                
              ),
                ]
              ),
              
            ],
           ),
           ),
           
        ),
      );
      },
      child: ContainerButtonModel(
        containerWidth: MediaQuery.of(context).size.width / 1.5,
        itext: "Comprar",
        bgColor: Color(0xFFEF6969),
      ),
    );
  }
}