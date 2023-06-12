import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/db_heper.dart';
import '../../res/global.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff48bf53),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.12,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                alignment: Alignment.centerLeft,
                height: height * 0.3,
                width: width * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Fast delivery at \nyour doorstep",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              "Home delivery and online reservation system for restaurants & cafe",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: height * 0.07,
              width: width,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () async {
                  SharedPreferences pres =
                      await SharedPreferences.getInstance();
                  print(Globals.data);
                  if (Globals.data == false) {
                    Globals.products.forEach((element) {
                      DBHleper.dbHleper.inserRecode(data: element);
                    });

                    Navigator.of(context).pushReplacementNamed('/');
                    pres.setBool('data', true);
                  } else {
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                },
                child: Text(
                  "Let's Explore",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
