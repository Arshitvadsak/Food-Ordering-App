import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_application/modals/productModal.dart';
import 'package:food_application/providers/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helpers/db_heper.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

late Future<List<Product>> getAllData;

late TabController tabController2;

int initialTabIndex2 = 0;

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController2 = TabController(length: 4, vsync: this, initialIndex: 0);
    getAllData = DBHleper.dbHleper.fetchSearchedRecode(data: "Fast Food");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "Hii Harshil",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                "Find Your Food",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                onChanged: (val) {
                  print(
                      "calllesd+________________${val}____________________________");
                  setState(() {
                    // searchFromFirebase(query: val);
                    DBHleper.dbHleper.fetchSearchedRecode(data: val);
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.green.shade100,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  suffixIcon: const Icon(
                    Icons.segment,
                    color: Colors.green,
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            TabBar(
                physics: BouncingScrollPhysics(),
                isScrollable: true,
                controller: tabController2,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                labelStyle:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                indicatorColor: Colors.transparent,
                onTap: (value) {
                  setState(() {
                    initialTabIndex2 = value;
                    if (initialTabIndex2 == 0) {
                      getAllData = DBHleper.dbHleper
                          .fetchSearchedRecode(data: "Fast Food");
                    }

                    if (initialTabIndex2 == 1) {
                      getAllData =
                          DBHleper.dbHleper.fetchSearchedRecode(data: "Fruits");
                    }
                    if (initialTabIndex2 == 2) {
                      getAllData = DBHleper.dbHleper
                          .fetchSearchedRecode(data: "Grocery");
                    }
                    if (initialTabIndex2 == 3) {
                      getAllData =
                          DBHleper.dbHleper.fetchSearchedRecode(data: "Veges");
                    }
                  });
                },
                tabs: [
                  Tab(
                    text: " Food ",
                  ),
                  Tab(
                    text: " Fruit ",
                  ),
                  Tab(
                    text: " Grocery ",
                  ),
                  Tab(
                    text: " Vegetable ",
                  )
                ]),
            FutureBuilder(
              future: getAllData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error : ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  List<Product>? data = snapshot.data;
                  return Container(
                    height: height * 0.56,
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: data!.length,
                      itemBuilder: (context, i) {
                        return Stack(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                height: height * 0.35,
                                width: width * 0.52,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * 0.017,
                                    ),
                                    Image.asset(data[i].image,
                                        height: height * 0.12),
                                    SizedBox(height: height * 0.017,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${data[i].name}",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight
                                                        .w600)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.222,
                              width: width * 0.52,
                              alignment: Alignment.bottomRight,
                              margin: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (data[i].like == "false") {
                                            Provider.of<CartProvider>(context,
                                                listen: false)
                                                .addToFavourite(product: data[i]);
                                          } else {
                                            Provider.of<CartProvider>(context,
                                                listen: false)
                                                .RemoveFromFavourite(
                                                product: data[i]);
                                          }
                                        });
                                      },
                                      icon: (data[i].like == "true") ? Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Colors.red,) : Icon(
                                        CupertinoIcons.heart, size: 25,
                                        color: Colors.red,
                                      ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (data[i].quantity == 0) {
                                          Provider.of<CartProvider>(context,
                                              listen: false)
                                              .addToCart(product: data[i]);
                                        } else {
                                          Provider.of<CartProvider>(context,
                                              listen: false)
                                              .RemoveFromCart(product: data[i]);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: (data[i].quantity == 0)
                                          ? Icon(
                                        Icons.add, color: Colors.white,)
                                          : Icon(
                                        Icons.delete, color: Colors.white,),
                                      decoration: BoxDecoration(
                                        color: (data[i].quantity == 0)
                                            ? Color(0xff48bf53).withOpacity(0.7)
                                            : Colors.red,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}
