import 'package:flutter/material.dart';
import 'package:online_food_order_app/const/colors.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  Text(
                    "Favorites",
                    style: TextStyle(fontSize: 25),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu),
                  )
                ],
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  'assets/img2.jpg',
                ),
              ),
              title: Text(
                'Pizza',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '\$50',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  SizedBox(width: 70),
                  Text('2 hours ago'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.remove_circle,
                    size: 25,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  'assets/img1.jpg',
                ),
              ),
              title: Text(
                'Pizza',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '\$50',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  SizedBox(width: 70),
                  Text('2 hours ago'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.remove_circle,
                    size: 25,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  'assets/img1.jpg',
                ),
              ),
              title: Text(
                'Pizza',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '\$50',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  SizedBox(width: 70),
                  Text('2 hours ago'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.remove_circle,
                    size: 25,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  'assets/img1.jpg',
                ),
              ),
              title: Text(
                'Pizza',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '\$50',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  SizedBox(width: 70),
                  Text('2 hours ago'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.remove_circle,
                    size: 25,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
