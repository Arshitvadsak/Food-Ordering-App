import 'package:flutter/material.dart';
import 'package:food_application/providers/cart_provider.dart';
import 'package:food_application/res/global.dart';
import 'package:food_application/views/screens/cart_screen.dart';
import 'package:food_application/views/screens/home_page.dart';
import 'package:food_application/views/screens/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prep = await SharedPreferences.getInstance();
  Globals.data = prep.getBool('data') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider()),
      ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Colors.green, primary: Colors.green)),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => home_page(),
          'splash_screen': (context) => IntroPage(),
          'cart_screen':(context)=>CartScreen(),
        },
      ),
    ),
  );
}
