// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import

import 'package:flower_app/component/list.dart';
import 'package:flower_app/constant/colors.dart';
// import 'package:flower_app/pages/component/list.dart';
import 'package:flower_app/pages/detailsScreen.dart';
import 'package:flower_app/pages/myProduct.dart';
import 'package:flower_app/widgets/appbar.dart';
import 'package:flower_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flower_app/provider/cart.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Home"),
        actions: [
          CartAndPrice(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 3,
              // mainAxisExtent: 2
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Positioned(
                    top: -10,
                    bottom: -10,
                    right: 1,
                    left: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Color.fromARGB(66, 73, 127, 110),
                          trailing: Consumer<Cart>(
                              builder: ((context, classInstancee, child) {
                            return IconButton(
                                onPressed: () {
                                  // if (!classInstancee.selectedItems
                                  //     .contains(items[index]))
                                    classInstancee.addItem(items[index]);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.red,
                                ));
                          })),
                          leading: Text(
                            "\$ ${items[index].price.toString()}",
                            style: const TextStyle(
                                color: Colors.red,),
                          ),
                          title: Text(""),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        DetailsScreen(product: items[index]))));
                          },
                          child: Image.asset(items[index].imgPath,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
