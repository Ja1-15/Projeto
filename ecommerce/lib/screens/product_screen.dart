import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/widgets/product_details_popup.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


  final List imageList = [
    "https://img.freepik.com/fotos-gratis/tags-com-venda-da-palavra_1156-327.jpg",
    "https://img.freepik.com/psd-premium/oferta-amarela-e-vermelha-com-megafone_658787-116.jpg?semt=ais_user"
    
  ];
class ProductScreen extends StatefulWidget {

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> images = [
    "images/image1.jpg",
    "images/image2.jpg",
    "images/image3.jpg",
    "images/image4.jpg",
  ];
  int counter = 1;

  final List<Widget> imageSliders = imageList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imageList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();



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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 370,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                    ),
                    items: imageList
                        .map((item) => Container(
                              child: Center(
                                  child:
                                      Image.network(item, fit: BoxFit.cover, width: 1000)),
                            ))
                        .toList(),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [SizedBox(height: 30,),
                      Text("Warm Zipper",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                        fontSize: 25
                      ),),
                      SizedBox(height: 5,),
                      Text("Hooded Jacket",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500
                      ),),
                      ],
                    ),
                    Text("\$300,00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(241, 9, 197, 40)
                    ),)
                  ],
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,),
                    onRatingUpdate: (rating) {
                    },
                  ),
                ),
                SizedBox(height: 10,),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Cool, windy weather is on its way. Send him out\nthe door in a jacket he wants to wear. Warm\nZooper Handed Jacket",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                        ),),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantidade",
                  style:TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                        fontSize: 18
                      ),)
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0x1F989797),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Row(                          
                          children:[IconButton.filled(
                          onPressed: (){
                             if(counter>=2){
                            decrementCounter();
                          }
                          }, 
                          icon: Icon(Icons.exposure_minus_1)),
                          SizedBox(width: 10,),
                          Text("$counter"),
                          SizedBox(width: 10,),
                          IconButton.filled(
                          onPressed: (){
                            incrementCounter();
                          }, 
                          icon: Icon(Icons.exposure_plus_1),
                          ),
                          SizedBox(width: 10,)
                          
                          ],
                        ),
                      ),
                    ),
                    ProductDetailsPopup()
                  ],
                ),
                
              ],
            ),
            
            ), 
        ),
      ),
    );
  }
}