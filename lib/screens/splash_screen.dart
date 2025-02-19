import 'dart:async'; // for timer
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // width and height
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/splash_pic.jpg',
          width: width,
          height: height * .4,
          fit: BoxFit.cover,
        ),
        // headline text
        SizedBox(
          height: height * .1,
        ),
        Text(
          "TOP HEADLINES",
          style: GoogleFonts.anton(color: Colors.grey.shade500),
        ),
        SizedBox(
          height: height * .1,
        ),
        SpinKitChasingDots(
          color: Colors.blue,
        ),
      ],
    ));
  }
}


// 💨💨💨💨💨💨💨💨💨  GPT CODE  💨💨💨💨💨💨💨💨💨
/*
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });

    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/splash_pic.jpg',
            width: width,
            height: height * 0.4,
            fit: BoxFit.cover,
          ),
          SizedBox(height: height * 0.1),
          Text(
            "TOP HEADLINES",
            style: GoogleFonts.anton(color: Colors.grey.shade500),
          ),
          SizedBox(height: height * 0.1),
          const SpinKitChasingDots(color: Colors.blue),
        ],
      ),
    );
  }
}

 */