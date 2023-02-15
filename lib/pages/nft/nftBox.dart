import 'package:flutter/material.dart';
import 'serializer/nft_metadata.dart';

class NFTBOX extends StatelessWidget {
  NFTBOX({Key? key, required this.tokenId, required this.nftMetadata})
      : super(key: key);
  final String tokenId;
  NFTMetadata nftMetadata;

  Widget build(BuildContext context) {
    print(nftMetadata.description);

    return Container(
        padding: EdgeInsets.all(2),
        height: 200,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              Image.network(nftMetadata.image),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(nftMetadata.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Container(
                            child: Text(
                              nftMetadata.description,
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )))
            ])));
  }
}
