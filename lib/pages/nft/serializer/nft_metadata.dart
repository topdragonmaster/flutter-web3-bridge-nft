import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:json_annotation/json_annotation.dart';

import 'media.dart';
import 'attribute.dart';
part 'nft_metadata.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class NFTMetadata {
  NFTMetadata(
    this.media,
    this.animationUrl,
    this.image,
    this.imageIpfs,
    this.imageData,
    this.externalUrl,
    this.description,
    this.name,
    this.edition,
    this.attributes,
    this.backgroundColor,
    this.thumbnailUrl,
    this.pofoUrl,
    this.pofoUrlIpfs,
    this.drmKey,
    this.drmVersion,
    this.drmType,
  );

  @JsonKey(required: false, defaultValue: [])
  List<Media>? media;
  @JsonKey(required: true, name: 'animation_url')
  String animationUrl;
  @JsonKey(required: true)
  String image;
  @JsonKey(required: true, name: 'image_ipfs')
  String imageIpfs;
  @JsonKey(required: false, name: 'image_data')
  String? imageData;
  @JsonKey(required: false, name: 'external_url')
  String? externalUrl;
  @JsonKey(required: true)
  String description;
  @JsonKey(required: true)
  String name;
  @JsonKey(required: true)
  int edition;
  @JsonKey(required: false)
  List<Attribute>? attributes;
  @JsonKey(required: false, name: 'background_color')
  String? backgroundColor;
  @JsonKey(required: false, name: 'thumbnail_url')
  String? thumbnailUrl;
  @JsonKey(required: false, name: 'pofo_url')
  String? pofoUrl;
  @JsonKey(required: false, name: 'pofo_url_ipfs')
  String? pofoUrlIpfs;
  @JsonKey(required: true, name: 'drm_key')
  String? drmKey;
  @JsonKey(required: true, name: 'drm_version')
  String? drmVersion;
  @JsonKey(required: true, name: 'drm_type')
  String? drmType;
  @JsonKey(ignore: true, defaultValue: "")
  static String? pinataApiKey;
  @JsonKey(ignore: true, defaultValue: "")
  static String? pinataSecretApiKey;
  @JsonKey(ignore: true)
  static String abi =
      "[{\"inputs\":[{\"internalType\":\"string\",\"name\":\"name\",\"type\":\"string\"},{\"internalType\":\"string\",\"name\":\"symbol\",\"type\":\"string\"}],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"approved\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"operator\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"bool\",\"name\":\"approved\",\"type\":\"bool\"}],\"name\":\"ApprovalForAll\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"},{\"indexed\":true,\"internalType\":\"bytes32\",\"name\":\"previousAdminRole\",\"type\":\"bytes32\"},{\"indexed\":true,\"internalType\":\"bytes32\",\"name\":\"newAdminRole\",\"type\":\"bytes32\"}],\"name\":\"RoleAdminChanged\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"sender\",\"type\":\"address\"}],\"name\":\"RoleGranted\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"sender\",\"type\":\"address\"}],\"name\":\"RoleRevoked\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"inputs\":[],\"name\":\"DEFAULT_ADMIN_ROLE\",\"outputs\":[{\"internalType\":\"bytes32\",\"name\":\"\",\"type\":\"bytes32\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"MINTER_ROLE\",\"outputs\":[{\"internalType\":\"bytes32\",\"name\":\"\",\"type\":\"bytes32\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"UPDATER_ROLE\",\"outputs\":[{\"internalType\":\"bytes32\",\"name\":\"\",\"type\":\"bytes32\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"burn\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"getApproved\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"}],\"name\":\"getRoleAdmin\",\"outputs\":[{\"internalType\":\"bytes32\",\"name\":\"\",\"type\":\"bytes32\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"},{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"grantRole\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"},{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"hasRole\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"operator\",\"type\":\"address\"}],\"name\":\"isApprovedForAll\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"},{\"internalType\":\"string\",\"name\":\"uri\",\"type\":\"string\"}],\"name\":\"mint\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"ownerOf\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"},{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"renounceRole\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"bytes32\",\"name\":\"role\",\"type\":\"bytes32\"},{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"revokeRole\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"safeTransferFrom\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"},{\"internalType\":\"bytes\",\"name\":\"data\",\"type\":\"bytes\"}],\"name\":\"safeTransferFrom\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"operator\",\"type\":\"address\"},{\"internalType\":\"bool\",\"name\":\"approved\",\"type\":\"bool\"}],\"name\":\"setApprovalForAll\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"bytes4\",\"name\":\"interfaceId\",\"type\":\"bytes4\"}],\"name\":\"supportsInterface\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"tokenByIndex\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"tokenOfOwnerByIndex\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"tokenURI\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"tokenId\",\"type\":\"uint256\"},{\"internalType\":\"string\",\"name\":\"uri\",\"type\":\"string\"}],\"name\":\"updateTokenURI\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]";
  factory NFTMetadata.fromJson(Map<String, dynamic> json) =>
      _$NFTMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$NFTMetadataToJson(this);

  static initializeIPFSConfig(
      {required String pinataApiKey, required String pinataSecretApiKey}) {
    NFTMetadata.pinataApiKey = pinataApiKey;
    NFTMetadata.pinataSecretApiKey = pinataSecretApiKey;
  }

  serialize(
      {required String rpcUrl,
      required int chainId,
      required String contractAddress,
      required String privateKey,
      required String tokenId}) async {
    try {
      Map pinataData = {
        "pinataMetadata": {
          "name": "$name.json",
        },
        "pinataContent": toJson()
      };

      //encode Map to JSON
      var body = json.encode(pinataData);

      var response = await http.post(
          Uri.parse("https://api.pinata.cloud/pinning/pinJSONToIPFS"),
          headers: {
            "Content-Type": "application/json",
            "pinata_api_key": NFTMetadata.pinataApiKey as String,
            "pinata_secret_api_key": NFTMetadata.pinataSecretApiKey as String,
          },
          body: body);

      await updateTokenURI(
          rpcUrl: rpcUrl,
          chainId: chainId,
          contractAddress: contractAddress,
          privateKey: privateKey,
          tokenId: tokenId,
          tokenURI: jsonDecode(response.body)['IpfsHash']);
    } catch (error) {
      print(error);
    }
  }

  static updateTokenURI(
      {required String rpcUrl,
      required int chainId,
      required String contractAddress,
      required String privateKey,
      required String tokenId,
      required String tokenURI}) async {
    final params = [BigInt.parse(tokenId), tokenURI];
    await executeContract(
        rpcUrl: rpcUrl,
        chainId: chainId,
        contractAddress: contractAddress,
        privateKey: privateKey,
        functionName: 'updateTokenURI',
        params: params);
  }

  static executeContract(
      {required String rpcUrl,
      required int chainId,
      required String contractAddress,
      required String privateKey,
      required String functionName,
      required List<dynamic> params}) async {
    final client = Web3Client(rpcUrl, http.Client());

    Credentials credentials = EthPrivateKey.fromHex(privateKey);
    final contract = DeployedContract(ContractAbi.fromJson(NFTMetadata.abi, ''),
        EthereumAddress.fromHex(contractAddress));
    final contractFunction = contract.function(functionName);

    await client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: contractFunction,
        parameters: params,
      ),
      chainId: chainId,
    );
  }

  static callContract(
      {required String rpcUrl,
      required String contractAddress,
      required String functionName,
      required List<dynamic> params}) async {
    final client = Web3Client(rpcUrl, http.Client());

    final contract = DeployedContract(ContractAbi.fromJson(NFTMetadata.abi, ''),
        EthereumAddress.fromHex(contractAddress));
    final callFunction = contract.function(functionName);
    return await client.call(
        contract: contract, function: callFunction, params: params);
  }

  static deserialize(
      {required String rpcUrl,
      required String contractAddress,
      required String tokenId}) async {
    try {
      var uri = await callContract(
          rpcUrl: rpcUrl,
          contractAddress: contractAddress,
          functionName: 'tokenURI',
          params: [BigInt.parse(tokenId)]);
      var response = await http.get(Uri.parse(uri[0]));

      return _$NFTMetadataFromJson(jsonDecode(response.body));
    } catch (error) {
      return error;
    }
  }

  static Future<List<String>> getAllTokenIdsforUser({
    required String rpcUrl,
    required String contractAddress,
    required String accountAddress,
  }) async {
    var balance = await callContract(
        rpcUrl: rpcUrl,
        contractAddress: contractAddress,
        functionName: 'balanceOf',
        params: [EthereumAddress.fromHex(accountAddress)]);

    final tokenIds = <String>[];

    if (balance[0] == 0) {
      return tokenIds;
    }

    for (int i = 0; i < balance[0].toInt(); i++) {
      try {
        var tokenId = await callContract(
            rpcUrl: rpcUrl,
            contractAddress: contractAddress,
            functionName: 'tokenOfOwnerByIndex',
            params: [EthereumAddress.fromHex(accountAddress), BigInt.from(7)]);
        tokenIds.add(tokenId[0].toString());
      } catch (e) {
        print(e);
      }
    }
    return tokenIds;
  }

  static Future<List<MetaDataMap>> getAllMetadata(
      {required String rpcUrl,
      required String contractAddress,
      required List<String> tokenIds}) async {
    if (tokenIds.isEmpty) {
      return [];
    }

    final metaData = <MetaDataMap>[];
    for (int i = 0; i < tokenIds.length; i++) {
      try {
        NFTMetadata data = await deserialize(
            rpcUrl: rpcUrl,
            contractAddress: contractAddress,
            tokenId: tokenIds[i]);
        metaData.add(MetaDataMap(tokenIds[i], data));
      } catch (e) {
        print(e);
      }
    }
    return metaData;
  }
}

class MetaDataMap {
  final String tokenId;
  final NFTMetadata nftMetadata;

  MetaDataMap(this.tokenId, this.nftMetadata);
}
