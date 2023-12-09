import 'package:flutter/material.dart';
import '../../const/colors.dart';
import '../../const/texts.dart';

class MenuDetails extends StatelessWidget {
  const MenuDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors['primary'],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: colors['white-color'],
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: colors['white-color'],
              )),
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
                child: Image.asset(
                  'assets/san_burger.jpg',
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
                      "Chicken Shawarma",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "20 min",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Icon(Icons.star),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "5(1.6 reviews) >",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: foodList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.white,
                                  height: 120,
                                  width: 100,
                                  child: Card(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: foodList[index].isChecked
                                                  ? Colors.greenAccent
                                                  : Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1)),
                                        ),
                                        Text(
                                          "Fish",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: Colors.grey[500]),
                                        ),
                                        Text(
                                          "\$3.5",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        menuDesc,
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
                          total,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 180,
                        ),
                        Icon(Icons.add),
                        Text(
                          "1",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.remove)
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
                          onPressed: () {},
                          child: Text(addCartdBtn,
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
