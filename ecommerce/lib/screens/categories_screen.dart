import 'package:ecommerce/post.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prestashop_api/prestashop_api.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;  
  late Future _future;
  var index;
  final logger = Logger();
  var receivedCategorias = [];

  final prestashop = PrestashopApi(
    BaseConfig(
      baseUrl: "b2b.redemachado.com.br",
      apiKey: "6YHPSTEE8JDS3EHCSXSG7BQ5A55ALJJA",
      protocol: Protocol.https,
    ),
  );



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this );
    _future = get_cat();
  }

  get_cat()async{
     final receivedCategories = await prestashop.getCategories(
      languageId: 2,
      filter: Filter.anyOf(CategoryFilterField.idParent, values: ['2']),
      display: const Display(
        displayFieldList: [
          CategoryDisplayField.id,
          CategoryDisplayField.name,
        ],
      ),
      sort: Sort(
        sortFieldOrderList: [SortFieldOrder.ascending(CategorySortField.description)],
      ),
    );
    return receivedCategorias = receivedCategories.entity;
  }

  build_cards(){
    for(var item in receivedCategorias) {
      InkWell(
                onTap: (){},
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Card(
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    ),
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            "images/hortifruti.jpg",
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        Text(
                                          item.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              );
    }
  }
                
  @override
  Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),
          ),
          title: Text("Categories", style: TextStyle(
            fontFamily: 'Varela', fontSize: 20, color: Color(0xFF545D68),
          ),),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none))
          ],
        ),
        body:
          FutureBuilder(
            future: _future,
            builder: (context, snapshot){
                return Container(
                  child: build_cards(),
                );                
            }
            
          )
        );
    
  }
}