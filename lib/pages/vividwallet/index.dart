import 'dart:math';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'staker.dart';

class VividWallet extends StatefulWidget {
  const VividWallet({super.key, required this.title});
  final String title;
  @override
  State<VividWallet> createState() => _VividWallet();
}

class _VividWallet extends State<VividWallet> {
  final TextEditingController _privatekeyController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  late Staker staker;

  final int remoteChainId = 5;
  final int nativeChainId = 1;
  final String remoteRpcUrl =
      "https://goerli.infura.io/v3/36a15dc96d82467fb7cc7e65cee1807b";
  final String nativeRpcUrl = "https://dev.videocoin.network/rpc";
  final String vividTokenAddress = "0xc35550282b2a7f2148dd4513c70f9daa1afa277c";
  final String proxyAddress = "0xc16de466447e348b6cd1b678d604990e6db3057c";
  final String localBridgeAddress =
      "0xb067b9a2eb0bd087f859f836e0ac23e0691ca62e";
  final String remoteBridgeAddress =
      "0x3cc38a35e3f93b7c57f44330c9584a48ef98e239";
  final String tokenBankAddress = "0x4d80ad6305b893a329039765134ddd436a87ff08";
  final String nativeBankAddress = "0xb8f52379ff40fe8ca57dc60ff24cea17bce043aa";

  String _accountAddress = "";
  double _nativeTokenBalance = 0;
  double _vividERC20Balance = 0;
  String _privateKey = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    staker = Staker(
        remoteChainId: remoteChainId,
        nativeChainId: nativeChainId,
        remoteRpcUrl: remoteRpcUrl,
        nativeRpcUrl: nativeRpcUrl,
        vividTokenAddress: vividTokenAddress,
        proxyAddress: proxyAddress,
        localBridgeAddress: localBridgeAddress,
        remoteBridgeAddress: remoteBridgeAddress,
        tokenBankAddress: tokenBankAddress,
        nativeBankAddress: nativeBankAddress);

    void asyncInit() async {
      bool success = await staker.initialize();
    }

    asyncInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(15),
              child: Text(
                "Control the vivid Gas Price and Rewards",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "My Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                                child: Text(
                              _accountAddress,
                              style: const TextStyle(
                                  fontSize: 19, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            )),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5);
                                    }
                                    return null; // Use the component's default.
                                  },
                                ),
                              ),
                              child: const Text('Import'),
                              onPressed: () {
                                _showDialog(context).then((value) async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    Credentials credentials =
                                        EthPrivateKey.fromHex(value.toString());
                                    String accountAddress =
                                        credentials.address.hex;
                                    BigInt vividERC20Balance =
                                        await staker.vividToken.getTokenBalance(
                                            address: accountAddress);
                                    double nativeTokenBalance = await staker
                                        .nativeProxy
                                        .getBalance(address: accountAddress);
                                    print(accountAddress);
                                    setState(() {
                                      _privateKey = value.toString();
                                      _accountAddress = accountAddress;
                                      _vividERC20Balance = vividERC20Balance /
                                          (BigInt.from(10).pow(18));
                                      _nativeTokenBalance =
                                          BigInt.from(nativeTokenBalance) /
                                              (BigInt.from(10).pow(18));
                                    });
                                  } catch (error, _) {
                                    showAlerDialog(
                                        context,
                                        ["Please type the valid privatekey."],
                                        "Message");
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5);
                                    }
                                    return null; // Use the component's default.
                                  },
                                ),
                              ),
                              child: const Text('Export'),
                              onPressed: () {
                                setState(() {
                                  _privateKey = "";
                                  _accountAddress = "";
                                  _vividERC20Balance = 0;
                                  _nativeTokenBalance = 0;
                                });
                              },
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                      child: Container(
                    decoration: roundBoxDecoration(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    // padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      TokenText(
                          title: "Vivid ERC20 Token Balance",
                          amount: _vividERC20Balance),
                      TokenText(
                          title: "Vivid Native Token Balance",
                          amount: _nativeTokenBalance)
                    ]),
                  )),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Exchange Amount",
                          hintText: 'Please input the amount of eths',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\d*\.?\d*)'))
                        ],
                        controller: _amountController,
                      )),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5);
                                    }
                                    return null; // Use the component's default.
                                  },
                                ),
                              ),
                              child: const Text('Found'),
                              onPressed: () async {
                                if (_amountController.text == "") {
                                  showAlerDialog(context,
                                      ["Please input the amount"], "Message");
                                  return;
                                }

                                if (_privateKey == "") {
                                  showAlerDialog(
                                      context,
                                      ["Please input the privatekey"],
                                      "Message");
                                  return;
                                }

                                String amount =
                                    (double.parse(_amountController.text) *
                                            pow(10, 18))
                                        .toString();
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await staker.fundVid(
                                      privateKey: _privateKey, amount: amount);
                                  BigInt vividERC20Balance =
                                      await staker.vividToken.getTokenBalance(
                                          address: _accountAddress);
                                  double nativeTokenBalance = await staker
                                      .nativeProxy
                                      .getBalance(address: _accountAddress);
                                  setState(() {
                                    _vividERC20Balance = vividERC20Balance /
                                        (BigInt.from(10).pow(18));
                                    _nativeTokenBalance =
                                        BigInt.from(nativeTokenBalance) /
                                            (BigInt.from(10).pow(18));
                                  });
                                } catch (e, _) {
                                  showAlerDialog(
                                      context, [e.toString()], "Message");
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5);
                                    }
                                    return null; // Use the component's default.
                                  },
                                ),
                              ),
                              child: const Text('Withdraw'),
                              onPressed: () async {
                                if (_amountController.text == "") {
                                  showAlerDialog(context,
                                      ["Please input the amount"], "Message");
                                  return;
                                }

                                if (_privateKey == "") {
                                  showAlerDialog(
                                      context,
                                      ["Please input the privatekey"],
                                      "Message");
                                  return;
                                }

                                String amount =
                                    (double.parse(_amountController.text) *
                                            pow(10, 18))
                                        .toString();
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await staker.withdrawVid(
                                      privateKey: _privateKey, amount: amount);
                                  BigInt vividERC20Balance =
                                      await staker.vividToken.getTokenBalance(
                                          address: _accountAddress);
                                  double nativeTokenBalance = await staker
                                      .nativeProxy
                                      .getBalance(address: _accountAddress);
                                  setState(() {
                                    _vividERC20Balance = vividERC20Balance /
                                        (BigInt.from(10).pow(18));
                                    _nativeTokenBalance =
                                        BigInt.from(nativeTokenBalance) /
                                            (BigInt.from(10).pow(18));
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                } catch (e, stackTrace) {
                                  showAlerDialog(
                                      context, [e.toString()], "Message");
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              child: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : Container(),
            ),
          ],
        ));
  }

  Future<String?> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Import Account"),
          content: TextFormField(
            decoration: const InputDecoration(
              labelText: "PrivateKey",
              hintText: 'Input Privatekey',
            ),
            controller: _privatekeyController,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context, _privatekeyController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAlerDialog(
    BuildContext context,
    List<String> msg, [
    String? title,
  ]) {
    final ok = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("OK"),
    );

    final alert = AlertDialog(
      // title added here
      title: title != null ? Text(title) : null,
      content: SingleChildScrollView(
        child: ListBody(
          children: msg.map((e) => Text(e)).toList(),
        ),
      ),
      actions: [ok],
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
}

BoxDecoration roundBoxDecoration() {
  return BoxDecoration(
    border: Border.all(width: 3.0),
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
  );
}

class TokenText extends StatelessWidget {
  const TokenText({Key? key, required this.title, required this.amount})
      : super(key: key);
  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          amount.toString(),
          style: const TextStyle(
            fontSize: 27,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
