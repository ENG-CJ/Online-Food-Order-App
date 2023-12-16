import 'package:cool_alert/cool_alert.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/const/url.dart';
import 'package:online_food_order_app/modals/foods.dart';
import 'package:online_food_order_app/pages/Login/login_page.dart';
import 'package:online_food_order_app/pages/favorites.dart';
import 'package:online_food_order_app/pages/my_cart.dart';
import 'package:online_food_order_app/pages/product_lists.dart';
import 'package:online_food_order_app/pages/profile.dart';
import 'package:online_food_order_app/pages/your_orders.dart';
import 'package:online_food_order_app/storage/local_storage.dart';
import 'package:online_food_order_app/util/button.dart';
import 'package:online_food_order_app/util/food_card.dart';
import 'package:online_food_order_app/util/info_content.dart';
import 'package:snackbar/snackbar.dart';

import '../modals/cateogries.dart';
import '../modals/user.dart';
import 'Menu/nenu.details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var dio = Dio();

  var isLoading = true;
  var loadingData = true;
  var hasError = true;
  var error = '';

  var loadCategories = true;
  List<Foods> foods = [];
  List<Categories> categories = [];
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

  var username = '';
  int id = 0;
  Future<bool> hasData(name) async {
    var isExist = false;

    try {
      var data = box.keys.map((e) {
        var user = box.get(e);
        return user;
      }).toList();

      var exists = data.where((element) => element['foodName'] == name);
      if (exists.length > 0)
        setState(() {
          isExist = true;
        });
      else
        setState(() {
          isExist = false;
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
        var favs = favBox.get(e);
        return favs;
      }).toList();

      var exists = data.where((element) => element['foodName'] == name);
      if (exists.length > 0)
        setState(() {
          isExist = true;
        });
      else
        setState(() {
          isExist = false;
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

  bool hasFav(name) {
    var isExist = false;
    try {
      var data = favBox.keys.map((e) {
        var favs = favBox.get(e);
        return favs;
      }).toList();

      var exists = data.where((element) => element['foodName'] == name);
      if (exists.length > 0)
        isExist = true;
      else
        isExist = false;
    } catch (e) {
      isExist = false;
    }
    return isExist;
  }

  Future<void> getFoods() async {
setState(() {
  loadingData=true;
});
    try {
      await Future.delayed(Duration(seconds: 2));
      Response response = await dio.get("$URL/foods");
      if(response.data['status']){
        if (response.data['data'].length > 0) {
          foods = (response.data['data'] as List)
              .map((e) => Foods.fromJson(e))
              .toList();
        }
        hasError=false;
      }else{
        hasError=true;
        error=response.data['description'];
      }



      loadingData = false;
      setState(() {});
    } catch (e) {
      print(" error $e ");
      loadingData = false;
      hasError=true;
      error=e.toString();
      setState(() {});
    }
  }

  Future<void> getAllCategories() async {
    try {
      Response response = await dio.get("$URL/categories");

      if (response.data['data'].length > 0) {
        categories = (response.data['data'] as List)
            .map((e) => Categories.fromJson(e))
            .toList();
      }
      print("data is $categories");
      loadCategories = false;
      setState(() {});
    } catch (e) {
      print(" error $e ");
      loadCategories = false;
      setState(() {});
    }
  }

  bool currentUserHasData = false;
  User? user;


  @override
  void initState() {
    super.initState();
    print(foods);
    getFoods().then((value) {});
    getAllCategories().then((value) {});
    LocalStorage().getCurrentUser().then((value) {
      if (value != null) {
         username = value;

      }
    });
    LocalStorage().getId().then((value) {

      if (value != null) {
        id = value;
      }
    });
  }
  
  
  Widget _buildFoodsMenus(List<Foods> foods){
    if(foods.length>0)
      return Container(
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
                  viewDetails: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              MenuDetails(food: foods[index]))),
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
                        "date": DateFormat("yyy-MM-dd")
                            .format(DateTime.now())
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "${foods[index].foodName} Added To The Favorites")));
                      setState(() {});
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
        ));
    
    
    return InfoContent(description: "Currently, There are no foods available", btnText: "Reload",click: (){
      getFoods();
    },);
      
  }
  Widget _buildCtegoryView(List<Categories> cat){
    if(cat.length>0)
      return  Padding(
        padding: const EdgeInsets.only(left: 14, right: 10, top: 6),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                // width: 200,
                height: 50,
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    return CButton(
                      onClick: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductList(
                                category: categories[index].name,
                              ))),
                      color: colors['primary']!.withAlpha(30),
                      widget: Center(
                          child: Text(
                            categories[index].name,
                            style: TextStyle(
                                color: colors['primary'],
                                fontFamily: "Poppins Medium"),
                          )),
                      width: 160,
                      height: 36,
                      radius: 6,
                    );
                  },
                  separatorBuilder: (_, i) => SizedBox(
                    width: 10,
                  ),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      );
    return Text("No Cateogries Data Found");
  }

  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors['body-color'],
      body: index==0? loadingData ? Center(child: CircularProgressIndicator(),): hasError?    InfoContent(description: error, btnText: "Reload",click: (){
      getFoods();
    },):  ModalProgressHUD(
        inAsyncCall: loadingData,
        child: SafeArea(
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
                        InkWell(
                          onLongPress: () {

                            CoolAlert.show(context: context, type: CoolAlertType.confirm,
                            title: "Confirm To Exit?",
                              confirmBtnText: "Exit",
                              cancelBtnText: "Return",
                              onConfirmBtnTap: (){

                                LocalStorage().clearLocalData().then((value){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()), (route) => false);
                                });
                              }
                            );
                          },
                          onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>Profile(
                                onLoad: (){
                                  LocalStorage().getCurrentUser().then((value){
                                    setState(() {
                                      if(value!=null)
                                      username=value;
                                    });
                                  });
                                },
                              )));
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("asset/avatar.png"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          username.split(" ")[0],
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
                        InkWell(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => FavoritePage())),
                            child: Icon(Icons.favorite_outlined, size: 30)),
                        SizedBox(
                          width: 8,
                        ),
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
             _buildCtegoryView(categories),
              // grudview
              Expanded(
                child: _buildFoodsMenus(foods),
              )
            ],
          ),
        ),
      ) : YourOrders(),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (newIndex){
          setState(() {
            index=newIndex;
          });
        },
        index: index,
        color: colors['primary'] as Color,
        backgroundColor: Colors.white,
        buttonBackgroundColor: colors['primary']!.withOpacity(0.74),
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),

          Icon(
            FontAwesomeIcons.shop,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
