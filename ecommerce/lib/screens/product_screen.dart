import 'package:ecommerce/widgets/product_details_popup.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                  child:  FanCarouselImageSlider.sliderType1(
                    sliderHeight: 350,
                    autoPlay: true,
                    imagesLink: images,
                    isAssets: true,
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
                      width: 135,
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