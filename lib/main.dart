import 'package:flutter/material.dart';
import 'pages/vividwallet/index.dart';
import 'pages/homepage.dart';
import 'pages/nft/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: (settings) {
      //Handle '/'
      if (settings.name == "/") {
        return MaterialPageRoute(builder: (contex) => HomeScreen());
      }
      //Handle '/vividwallet'
      if (settings.name == "vividwallet") {
        return MaterialPageRoute(
            builder: (context) =>const VividWallet(title: "VividWallet"));
      }
      //Handle '/nft'
      if (settings.name == "nft") {
        return MaterialPageRoute(
            builder: (context) =>const VividNFT(title: "VividNFT"));
      }
    });
  }
}
