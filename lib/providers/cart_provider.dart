import 'package:flutter/material.dart';

import '../modals/productModal.dart';

class CartProvider extends ChangeNotifier {
  List<Product> allcart = [];
  List<Product> favoritelist = [];

  get allProduct {
    int totalcount = 0;
    allcart.forEach((element) {
      totalcount += element.quantity;
    });
    return totalcount;
  }

  get totalPrice {
    num price = 0;
    for (int i = 0; i < allcart.length; i++) {
      price += (allcart[i].price * allcart[i].quantity);
    }
    return price;
  }

  void Countpluse({required Product product}) {
    product.quantity++;
    notifyListeners();
  }

  void CountdecrementAndRemove({required Product product}) {
    if (product.quantity > 1) {
      product.quantity--;

      notifyListeners();
    }
  }

  void RemoveFromCart({required Product product}) {
    product.quantity = 0;
    print(product.quantity);
    allcart.remove(product);

    notifyListeners();
  }

  void addToCart({required Product product}) {
    if (product.quantity >= 1) {
      print(product.quantity);
      // print("same");
    } else {
      // print("add cart");

      product.quantity++;
      allcart.add(product);

      notifyListeners();
    }
  }

  void addToFavourite({required Product product}) {
    product.like = "true";
    favoritelist.add(product);

    notifyListeners();
  }

  void RemoveFromFavourite({required Product product}) {
    product.like = "false";
    print(product.like);
    favoritelist.remove(product);

    notifyListeners();
  }
}
