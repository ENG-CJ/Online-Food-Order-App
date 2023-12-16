import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/const/url.dart';
import 'package:online_food_order_app/pages/home.dart';

import '../util/button.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  
  var favBox = Hive.box("fav");
  var box = Hive.box("cart");
  List favs=[];
  
  void loadFav(){
    try{
      favs=favBox.keys.map((key){
        return favBox.get(key);
      }).toList();
      print(favs);
    }catch(e){
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

  void addToCart(Map<String, dynamic> data) {
    try {
      box.add(data);
    } catch (e) {
      print(e);
    }
  }
  
  Widget buildFav(List items){
     if(items.length>0)
       return  ListView.separated(
         shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
         itemBuilder: (_,index){
           return  Slidable(
             endActionPane: ActionPane(
               motion: const ScrollMotion(),
               children: [
                 SlidableAction(onPressed: (_){
                   CoolAlert.show(context: context, type: CoolAlertType.confirm,
                     text: "Remove ${favs[index]['foodName']} From Favorites?",
                     onConfirmBtnTap: (){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                           "Removed ${favs[index]['foodName']} From Favorites"
                       )));
                       favBox.deleteAt(index);
                       loadFav();
                       setState(() {

                       });
                     },
                     confirmBtnText: "Yes",
                     cancelBtnText: "No",
                   );
                 },
                   backgroundColor: Colors.red,
                   foregroundColor: Colors.white,
                   icon: FontAwesomeIcons.xmark,)
               ],
             ),
             child: ListTile(
               leading: CircleAvatar(
                 radius: 30,
                 backgroundImage: NetworkImage(
                   '$URL/uploads/${favs[index]['image']}',
                 ),
               ),
               title: Text(
                 favs[index]['foodName'],
                 style: TextStyle(fontSize: 20),
               ),
               subtitle: Row(
                 children: [
                   Text(
                     '\$${favs[index]['price']}',
                     style: TextStyle(color: Colors.green, fontSize: 20),
                   ),
                   SizedBox(width: 70),

                 ],
               ),
               trailing:  InkWell(
                 onTap: () {
                   hasData(favs[index]['foodName']).then((value) {
                     if (value) {
                       CoolAlert.show(
                           context: context,
                           type: CoolAlertType.info,
                           title:
                           "The Item With name ${favs[index]['foodName']} Already Exist");

                       return;
                     }
                     addToCart({
                       "food_id": favs[index]['food_id'],
                       "original": favs[index]['original'],
                       "image": favs[index]['image'],
                       "foodName": favs[index]['foodName'],
                       "cat": favs[index]['cat'],
                       "price": favs[index]['price']
                     });
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${favs[index]['foodName']} Added to the fav")));
                   });
                 },
                 child: Icon(
                   Icons.shopping_cart,
                   size: 25,
                   color: Colors.green,
                 ),
               ),
             ),
           );
         }, separatorBuilder: (_,index)=>SizedBox(
         height: 30,
         child: Divider(
           color: Colors.grey,
           thickness: 2,
         ),
       ), itemCount: favs.length,


       );

     return Center(

       child: Padding(
         padding: const EdgeInsets.only(
             top: 100,
             left: 30,
             right: 20
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.asset("asset/no data.png",width: 210,),
             SizedBox(height: 10,),
             Text(
                 textAlign: TextAlign.center,
                 style: TextStyle(
                     fontSize: 16,
                     fontFamily: "Poppins Bold"

                 ),"We couldn't find any items in your Favorites. Please consider adding items to your Favs now.!"),
             SizedBox(height: 20,),
             CButton(
                 onClick: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home())),
                 widget: Center(child: Text("Back",style: TextStyle(color: Colors.white,fontFamily: "Poppins Bold"),),))

           ],
         ),
       ),
     );
       
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFav();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Text(
                    "Favorites",
                    style: TextStyle(fontSize: 25),
                  ),

                ],
              ),
            ),
           buildFav(favs)


          ],
        ),
      ),
    );
  }
}
