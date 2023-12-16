import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:online_food_order_app/util/info_content.dart';

import '../const/colors.dart';
import '../const/url.dart';
import '../modals/cateogries.dart';
import '../modals/foods.dart';
import '../util/food_card.dart';
import 'Menu/nenu.details.dart';

class ProductList extends StatefulWidget {
  final String category;
  const ProductList({super.key,required this.category});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  var dio = Dio();

  var isLoading = true;
  var hasError = false;
  var errorDescr = '';
  var loadCategories = true;
  List<Foods> foods = [];
  var box = Hive.box("cart");
  var favBox = Hive.box("fav");

  void addToCart(Map<String, dynamic> data) {
    try {
      box.add(data);
    } catch (e) {
      print(e);
    }
  }

  void addToFav(Map<String, dynamic> data) {
    try {
      favBox.add(data);
    } catch (e) {
      print(e);
    }
  }


  Future<bool> hasData(name) async {
    var isExist = false;
    try {

      var data = box.keys.map((e) {
        var user=box.get(e);
        return user;
      }).toList();

      var exists=data.where((element) => element['foodName']==name);
      if(exists.length>0)
        setState(() {
          isExist = true;
        });
      else
        setState(() {
          isExist=false;
        });
      print("run1");
    } catch (e) {
      setState(() {
        isExist = false;
      });
      print("run2");
    }
    return isExist;
  }

  bool hasFavData(name) {
    var isExist = false;
    try {

      var data = favBox.keys.map((e) {
        var favs=favBox.get(e);
        return favs;
      }).toList();

      var exists=data.where((element) => element['foodName']==name);
      if(exists.length>0)
        setState(() {
          isExist = true;
        });
      else
        setState(() {
          isExist=false;
        });
      print("run1");
    } catch (e) {
      setState(() {
        isExist = false;
      });
      print("run2");
    }
    return isExist;
  }
  bool  hasFav(name) {
    var isExist = false;
    try {

      var data = favBox.keys.map((e) {
        var favs=favBox.get(e);
        return favs;
      }).toList();

      var exists=data.where((element) => element['foodName']==name);
      if(exists.length>0)
        isExist = true;
      else
        isExist=false;

    } catch (e) {

      isExist = false;

    }
    return isExist;
  }

  Future<void> getFoods() async {
    setState(() {
      loadCategories=true;
    });

    try {
      await Future.delayed(Duration(seconds: 1));
      Response response = await dio.post("$URL/foods/specificCategories", data: {"category": widget.category});

      if(response.data['status']){
        if (response.data['data'].length > 0) {
          foods = (response.data['data'] as List)
              .map((e) => Foods.fromJson(e))
              .toList();
        }
        hasError=false;
      }else{
        hasError=true;
        errorDescr=response.data['description'];
      }

      loadCategories=false;
      setState(() {});
      print("after state");
    } catch (e) {
      print(e);
      print(" error $e ");
      loadCategories = false;
      hasError=true;
      errorDescr=e.toString();
      setState(() {});
    }
  }

  Widget buildProductDetails(List<Foods> foods){
    if(hasError)
      return InfoContent(description: errorDescr,btnText: "Reload",click: ()=> getFoods(),);
    if(foods.length>0)
      return  Padding(
        padding: const EdgeInsets.only(top: 18,left: 8,right: 8,bottom: 30),
        child: GridView.builder(
            itemCount: foods.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 7,
                mainAxisExtent: 240),
            itemBuilder: (_, index) {

              return FoodCard(
                viewDetails: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>MenuDetails(food: foods[index]))),
                isFavoriteFood: hasFav(foods[index].foodName),
                foods: foods[index],
                getData: (value) {
                  var value = hasFavData(foods[index].foodName);
                  if (value) {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.info,

                        title:
                        "The Item With name ${foods[index].foodName} Already Exist");
                  } else {
                    addToFav({
                      "food_id": foods[index].id,
                      "original": foods[index].price,
                      "image": foods[index].image,
                      "foodName": foods[index].foodName,
                      "cat": foods[index].name,
                      "price": foods[index].price,
                      "date": DateFormat("yyy-MM-dd").format(DateTime.now())
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${foods[index].foodName} Added To The Favorites")));
                    setState(() {

                    });
                  }

                },
                onclick: () {

                  hasData(foods[index].foodName).then((value) {

                    if (value) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.info,
                          title:
                          "The Item With name ${foods[index].foodName} Already Exist");
                    } else {
                      addToCart({
                        "food_id": foods[index].id,
                        "original": foods[index].price,
                        "image": foods[index].image,
                        "foodName": foods[index].foodName,
                        "cat": foods[index].name,
                        "price": foods[index].price
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "${foods[index].foodName} Added To The Cart")));
                    }
                  });
                },
              );
            }),
      );

    return InfoContent(description: 'No Data Found Based On This Category',btnText: "Back",click: ()=> Navigator.pop(context),);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFoods().then((value) {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors['body-color'],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 18
                ),
                child: Row(
                  children: [
                    InkWell(
                        onTap: ()=> Navigator.pop(context),
                        child: Icon(Icons.arrow_back,size: 40,))
                    ,
                    SizedBox(width: 18,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product List",style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Poppins Bold"
                        ),),
                        Text("All Products From Category #${widget.category}"),
                      ],
                    )
                  ],
                ),
              ),
              loadCategories? Padding(
                padding: const EdgeInsets.only(
                  top: 100
                ),
                child: Center(child: CircularProgressIndicator(),),
              ) :
              buildProductDetails(foods)
            ],
          ),
        )
      ),
    );
  }
}
