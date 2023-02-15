import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:async';
import 'serializer/nft_metadata.dart';
import 'nftBox.dart';

class VividNFT extends StatefulWidget {
  const VividNFT({super.key, required this.title});
  final String title;
  @override
  State<VividNFT> createState() => _VividNFT();
}

class _VividNFT extends State<VividNFT> {
  final TextEditingController _privatekeyController = TextEditingController();
  final TextEditingController _contractAddressController =
      TextEditingController();

  bool isLoading = false;
  String _accountAddress = "";
  String _privateKey = "";
  String _contractAddress = "";
  String _blockChain = 'Polygon';
  List<String> _tokenIds = [];
  List<MetaDataMap> _nftMetaDataList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.red,
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(15),
              child: Text(
                "Serialize your NFT metadata.",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
        ),
        body: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      // padding: const EdgeInsets.all(2),
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (_privateKey.isNotEmpty)
                            Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Network: "),
                                  Container(
                                      width: 120,
                                      child: Text(
                                        _blockChain,
                                        style: const TextStyle(
                                            fontSize: 19, color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Contract Address: "),
                                  Container(
                                      width: 120,
                                      child: Text(
                                        _contractAddress,
                                        style: const TextStyle(
                                            fontSize: 19, color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Account Address: "),
                                  Container(
                                      width: 120,
                                      child: Text(
                                        _accountAddress,
                                        style: const TextStyle(
                                            fontSize: 19, color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                            ]),
                          Expanded(
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
                                        return Colors.red.withOpacity(0.5);
                                      }
                                      return Colors
                                          .red; // Use the component's default.
                                    },
                                  ),
                                ),
                                child: const Text('Import'),
                                onPressed: () {
                                  _showDialog(context).then((_) async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Credentials credentials =
                                        EthPrivateKey.fromHex(
                                            _privatekeyController.text);
                                    String accountAddress =
                                        credentials.address.hex;
                                    //change the rpc url according to _blockchain
                                    var tokenIds =
                                        await NFTMetadata.getAllTokenIdsforUser(
                                            rpcUrl: "https://polygon-rpc.com",
                                            contractAddress:
                                                _contractAddressController.text,
                                            accountAddress: accountAddress);

                                    var nftMetadataList =
                                        await NFTMetadata.getAllMetadata(
                                            rpcUrl: "https://polygon-rpc.com",
                                            contractAddress:
                                                _contractAddressController.text,
                                            tokenIds: tokenIds);
                                    setState(() {
                                      _privateKey = _privatekeyController.text;
                                      _accountAddress = accountAddress;
                                      _contractAddress =
                                          _contractAddressController.text;
                                      _tokenIds = tokenIds;
                                      _nftMetaDataList = nftMetadataList;
                                    });

                                    setState(() {
                                      isLoading = false;
                                    });
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
                                        return Colors.red.withOpacity(0.5);
                                      }
                                      return Colors
                                          .red; // Use the component's default.
                                    },
                                  ),
                                ),
                                child: const Text('Export'),
                                onPressed: () {
                                  setState(() {
                                    _privateKey = "";
                                    _accountAddress = "";
                                    _contractAddress = "";
                                    _tokenIds = [];
                                    _nftMetaDataList = [];
                                  });
                                },
                              ),
                            ],
                          ))
                        ],
                      )),
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
                    itemCount: _nftMetaDataList.length,
                    itemBuilder: (context, index) {
                      var currentItem = _nftMetaDataList[index];
                      return NFTBOX(
                          tokenId: currentItem.tokenId,
                          nftMetadata: currentItem.nftMetadata);
                    },
                  ))
                ]),
            Positioned(
              child: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
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
    var items = ['Polygon', 'VideoCoin'];
    // String blockChain = items[0];
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setStateSB) => AlertDialog(
                  title: Text("Import Account"),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        value: _blockChain,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _blockChain = newValue.toString();
                          });
                          setStateSB(() {
                            _blockChain = newValue.toString();
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Contract Address",
                          hintText: 'Input Contract Address',
                        ),
                        controller: _contractAddressController,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "PrivateKey",
                          hintText: 'Input Privatekey',
                        ),
                        controller: _privatekeyController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red.withOpacity(0.5);
                            }
                            return Colors.red; // Use the component's default.
                          },
                        ),
                      ),
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
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
