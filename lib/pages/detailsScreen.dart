// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:flower_app/component/list.dart';
import 'package:flower_app/constant/colors.dart';
import 'package:flower_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {

  Item product;
  DetailsScreen( { required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}
// flutterfire configure --project=flower-app-67110
class _DetailsScreenState extends State<DetailsScreen> {
  bool isShowMore = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text(
          "Details ",
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          CartAndPrice()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(widget.product.imgPath),
              SizedBox(
                height: 10,
              ),
              Text(
                "\$ ${widget.product.price.toString()}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        // color: Colors.amber,
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 212, 177),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("New"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.edit_location),
                      Text(
                        "Flower Shop",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  " Detils : ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 19),
                ),
              ),
              Text(
                "Ship september to March Kit includes pot, & growing medium and giant bulb Attractive Gift Box makes a great gift Easy to grow Bulb Size: 26/28 cm Cooler fresh bulbs stored in our temperature controlled bulb storage rooms Giant Amaryllis are easy and thrilling to grow indoors, and a great gift for a child or the home bound person. Unlike many other amaryllis bulbs on the market, our large hybrid bulbs will produce two 18-24 stems, each bearing 4 or 5 huge, long lasting flowers that are over 8 inches in diameter. Ever grown an amaryllis inside the house? Itis a snap. ",
                style: TextStyle(fontSize: 18),
                maxLines: (isShowMore) ? 3 : null,
                overflow: TextOverflow.fade,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isShowMore = !isShowMore;
                    });
                  },
                  child: Text(
                    isShowMore ? "show more " : "show less",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
