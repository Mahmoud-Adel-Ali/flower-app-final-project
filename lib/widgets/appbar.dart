

import 'package:flower_app/pages/myProduct.dart';
import 'package:flower_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartAndPrice extends StatelessWidget {
  const CartAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return  Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(211, 164, 255, 193),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        classInstancee.selectedItems.length.toString(),
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const MyProduct())));
                        },
                        icon: const Icon(Icons.add_shopping_cart)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "\$ ${classInstancee.price.toString()}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
            ;
  }
}