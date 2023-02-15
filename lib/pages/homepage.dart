import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vivid Homepage")),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          GestureDetector(
              child: Container(
                  height: 200,
                  color: Colors.blue,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "VividWallet",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          "Control the vivid Gas Price and Rewards",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        )
                      ])),
              onTap: () {
                Navigator.pushNamed(context, "vividwallet");
              }),
          Divider(),
          GestureDetector(
              child: Container(
                  height: 200,
                  color: Colors.red,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NFT",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          "Serialize and Deserialize your NFT metadata",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        )
                      ])),
              onTap: () {
                Navigator.pushNamed(context, "nft");
              }),
        ],
      )),
    );
  }
}
