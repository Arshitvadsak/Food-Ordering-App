import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_application/views/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../modals/productModal.dart';
import '../../providers/cart_provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 14,
              child: ListView.builder(
                  itemCount: Provider.of<CartProvider>(context).favoritelist.length,
                  itemBuilder: (contecxt, i) {
                    Product product =
                    Provider.of<CartProvider>(context).favoritelist[i];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          height: height * 0.2,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        product.image,
                                        height: height * 0.10,
                                      ),
                                      Text(
                                        "${product.name.split(" ")[0]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  )),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Price : ₹${product.price}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Provider.of<CartProvider>(context,
                                                  listen: false)
                                                  .RemoveFromFavourite(
                                                  product: product);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),)
                                      ],
                                    )
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
