import 'package:cool_alert/cool_alert.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/const/url.dart';
import 'package:online_food_order_app/modals/foods.dart';
import 'package:online_food_order_app/pages/my_cart.dart';
import 'package:online_food_order_app/util/button.dart';
import 'package:online_food_order_app/util/food_card.dart';
import 'package:snackbar/snackbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var dio = Dio();

  var isLoading = true;
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
    try {
      Response response = await dio.get("$URL/foods");

      if (response.data['data'].length > 0) {
        foods = (response.data['data'] as List)
            .map((e) => Foods.fromJson(e))
            .toList();
      }

      isLoading = false;
      setState(() {});
    } catch (e) {
      print(" error $e ");
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    print(foods);
    getFoods().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors['body-color'],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 10, top: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("asset/cj.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "ENG-CJ",
                        style:
                            TextStyle(fontSize: 24, fontFamily: "Poppins Bold"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MyCart()));
                        },
                        child: Icon(
                          Icons.shopping_cart,
                          size: 30,
                          color: colors['primary'],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.favorite_outlined, size: 30),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.search, size: 30),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 18),
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors['primary']!.withOpacity(0.6)),
                child: Stack(clipBehavior: Clip.none, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "60% OFF",
                        style: TextStyle(
                            fontFamily: "Poppins Bold",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "we are happy to share this big\ndiscount for you let’s your\nfavorite food",
                        style: TextStyle(
                            fontSize: 12, fontFamily: "Poppins Light"),
                      )
                    ],
                  ),
                  Positioned(
                    width: 210,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: SizedBox(child: Image.asset("asset/one.jpg"))),
                    right: -76,
                    top: -20,
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 10, top: 18),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontFamily: "Poppins Medium"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 10, top: 6),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CButton(
                      widget: Center(
                          child: Text(
                        "All",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Poppins Bold"),
                      )),
                      width: 51,
                      height: 36,
                      radius: 6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CButton(
                      color: colors['primary']!.withAlpha(30),
                      widget: Center(
                          child: Text(
                        "Pizza Alchab",
                        style: TextStyle(
                            color: colors['primary'],
                            fontFamily: "Poppins Medium"),
                      )),
                      width: 100,
                      height: 36,
                      radius: 6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CButton(
                      color: colors['primary']!.withAlpha(30),
                      widget: Center(
                          child: Text(
                        "Pizza Alchab",
                        style: TextStyle(
                            color: colors['primary'],
                            fontFamily: "Poppins Medium"),
                      )),
                      width: 100,
                      height: 36,
                      radius: 6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CButton(
                      color: colors['primary']!.withAlpha(30),
                      widget: Center(
                          child: Text(
                        "Pizza Alchab",
                        style: TextStyle(
                            color: colors['primary'],
                            fontFamily: "Poppins Medium"),
                      )),
                      width: 100,
                      height: 36,
                      radius: 6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CButton(
                      color: colors['primary']!.withAlpha(30),
                      widget: Center(
                          child: Text(
                        "Pizza Alchab",
                        style: TextStyle(
                            color: colors['primary'],
                            fontFamily: "Poppins Medium"),
                      )),
                      width: 100,
                      height: 36,
                      radius: 6,
                    )
                  ],
                ),
              ),
            ),
            // grudview
            Expanded(
              child: Container(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: foods.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 7,
                          mainAxisExtent: 240),
                      itemBuilder: (_, index) {

                        return FoodCard(
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
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        color: colors['primary'] as Color,
        backgroundColor: Colors.white,
        buttonBackgroundColor: colors['primary']!.withOpacity(0.74),
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
