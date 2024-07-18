import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/screens/product_screen.dart';
import 'package:flutter/material.dart';


  final List imageList = [
    "https://img.freepik.com/fotos-gratis/tags-com-venda-da-palavra_1156-327.jpg",
    "https://img.freepik.com/psd-premium/oferta-amarela-e-vermelha-com-megafone_658787-116.jpg?semt=ais_user"
    
  ];

class HomeScreen extends StatelessWidget {
  
  List tabs = [
    "All", "Category", "Top", "Recommended"
  ];

  List imgList = [
    "images/image1.jpg",
    "images/image2.jpg",
    "images/image3.jpg",
    "images/image4.jpg",
  ];


  List productTitle = [
    "Warm Zipper",
    "Knitted Wool",
    "Zipper Win",
    "Child Win", 
  ];
  List prices = [
    "\$300",
    "\$650",
    "\$50",
    "\$100"
  ];
  List reviews = [
    "54",
    "120",
    "542",
    "534",
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(                      
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,
                            color: Color(0xFFEF6969),),
                            border: InputBorder.none,
                            label: Text("Find your product",
                            style: TextStyle(),),
                          ),
                        ),    
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 6,
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.notifications_none,
                        color: Color(0xFFEF6969),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                    return  FittedBox(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Text(tabs[index],
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                          ),
                        ),
                      ),
                    );
                  } ),
                ),
                SizedBox(height: 20,),

                //OFERTAS

                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Ofertas",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 250,
                  child: ListView.builder(
                    itemCount: imgList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder:(context, index){
                      return Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen()));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(imgList[index]),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.favorite,
                                        size: 18,
                                        ),
                                        ),
                                    ), 
                                    ),
                              ],),
                            ),
                            SizedBox(height: 10,),
                            Text(productTitle[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,

                            ),),
                             SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 22,),
                                Text('('+reviews[index]+')'),
                                SizedBox(width: 10,),
                                Text(prices[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,                              
                                ),),
                                SizedBox(width: 10,)
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    ),
                ),

                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF0DD),
                    borderRadius: BorderRadius.circular(20),
                  ),
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
                SizedBox(height: 15),

                //MAIS COMPRADOS


                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Mais Comprados",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 250,
                  child: ListView.builder(
                    itemCount: imgList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder:(context, index){
                      return Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: (){
                        
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(imgList[index]),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.favorite,
                                        size: 18,
                                        ),
                                        ),
                                    ), 
                                    ),
                              ],),
                            ),
                            SizedBox(height: 10,),
                            Text(productTitle[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,

                            ),),
                             SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 22,),
                                Text('('+reviews[index]+')'),
                                SizedBox(width: 10,),
                                Text(prices[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,                              
                                ),),
                                SizedBox(width: 10,)
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}