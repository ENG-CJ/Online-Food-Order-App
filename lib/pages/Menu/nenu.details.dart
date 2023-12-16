import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:online_food_order_app/const/url.dart';
import 'package:online_food_order_app/modals/foods.dart';
import '../../const/colors.dart';
import '../../const/texts.dart';

class MenuDetails extends StatefulWidget {
  final Foods food;
  const MenuDetails({super.key,required this.food});

  @override
  State<MenuDetails> createState() => _MenuDetailsState();
}

class _MenuDetailsState extends State<MenuDetails> {
  var favBox = Hive.box("fav");
  void addToFav(Map<String, dynamic> data) {
    try {
      favBox.add(data);
    } catch (e) {
      print(e);
    }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors['primary'],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: colors['white-color'],
            )),
        actions: [
          hasFavData(widget.food.foodName) ? InkWell(
            onTap: (){
              CoolAlert.show(context: context, type: CoolAlertType.info,title: "Item ${widget.food.foodName} Already Exist in Fav Box");
            },
            child: Icon(
            Icons.favorite,
            color: colors['white-color'],
          ),) : InkWell(
            onTap: (){
              addToFav({
                "food_id": widget.food.id,
                "original":widget.food.price,
                "image": widget.food.image,
                "foodName":widget.food.foodName,
                "cat": widget.food.name,
                "price": widget.food.price,
                "date": DateFormat("yyy-MM-dd").format(DateTime.now())
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${widget.food.foodName} Added To Favs")));
            },
            child: Icon(
            Icons.favorite_border,
            color: colors['white-color'],
          ),),

        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: colors['primary'],
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.77,
                  decoration: BoxDecoration(
                      color: colors['white-color'],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ))
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 25,
                    offset: Offset(1, 6),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  '$URL/uploads/${widget.food.image}',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top: 235,
              left: 50,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  children: [
                    Text(
                      "${widget.food.foodName}",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.food.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),


                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        widget.food.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Price \$${widget.food.price}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 180,
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colors['primary'],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                          onPressed: () {  Navigator.pop(context);},
                          child: Text("Home",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: colors['body-color'],
                                      fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class Food {
  final String name;
  final double price;
  final bool isChecked;

  Food(this.name, this.price, {this.isChecked = false});
}

List<Food> foodList = [
  Food('Fish', 5.99, isChecked: true),
  Food('Chicken', 8.49),
  Food('Beef', 6.25),
];
