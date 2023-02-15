import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class BlockchainService {
  int chainId;
  late Web3Client client;

  BlockchainService({required this.chainId, required String rpcUrl}) {
    client = Web3Client(rpcUrl, http.Client());
  }

  Future<double> getBalance({required String address}) async {
    var balance = await client.getBalance(EthereumAddress.fromHex(address));
    return balance.getValueInUnit(EtherUnit.wei);
  }

  Future<String> sendEth(
      {required String privateKey,
      required String to,
      required String amount}) async {
    Credentials credentials = EthPrivateKey.fromHex(privateKey);

    var balance = await getBalance(address: credentials.address.hex);
    if (BigInt.from(balance) < BigInt.parse(amount)) {
      throw Exception("Insufficent Fund");
    }
    return await client.sendTransaction(
      credentials,
      Transaction(
        to: EthereumAddress.fromHex(to),
        value: EtherAmount.fromBase10String(EtherUnit.wei, amount),
      ),
    );
  }

  Future<bool> waitMined({required String txHash}) async {
    TransactionReceipt? tr;
    while (tr != null) {
      tr = await client.getTransactionReceipt(txHash);
    }
    bool? status = tr?.status;
    if (status != null && !status) {
      throw Exception("Transaction Reverted");
    }
    return true;
  }

  // static updateTokenURI(
  //     {required String rpcUrl,
  //     required int chainId,
  //     required String contractAddress,
  //     required String privateKey,
  //     required String tokenId,
  //     required String tokenURI}) async {
  //   final params = [BigInt.parse(tokenId), tokenURI];
  //   await executeContract(
  //       rpcUrl: rpcUrl,
  //       chainId: chainId,
  //       contractAddress: contractAddress,
  //       privateKey: privateKey,
  //       functionName: 'updateTokenURI',
  //       params: params);
  // }

  // static executeContract(
  //     {required String rpcUrl,
  //     required int chainId,
  //     required String contractAddress,
  //     required String privateKey,
  //     required String functionName,
  //     required List<dynamic> params}) async {
  //   final client = Web3Client(rpcUrl, http.Client());

  //   Credentials credentials = EthPrivateKey.fromHex(privateKey);
  //   final contract = DeployedContract(ContractAbi.fromJson(NFTMetadata.abi, ''),
  //       EthereumAddress.fromHex(contractAddress));
  //   final contractFunction = contract.function(functionName);

  //   await client.sendTransaction(
  //     credentials,
  //     Transaction.callContract(
  //       contract: contract,
  //       function: contractFunction,
  //       parameters: params,
  //     ),
  //     chainId: chainId,
  //   );
  // }

  // static callContract(
  //     {required String rpcUrl,
  //     required String contractAddress,
  //     required String functionName,
  //     required List<dynamic> params}) async {
  //   final client = Web3Client(rpcUrl, http.Client());

  //   final contract = DeployedContract(ContractAbi.fromJson(NFTMetadata.abi, ''),
  //       EthereumAddress.fromHex(contractAddress));
  //   final callFunction = contract.function(functionName);
  //   return await client.call(
  //       contract: contract, function: callFunction, params: params);
  // }

  // static deserialize(
  //     {required String rpcUrl,
  //     required String contractAddress,
  //     required String tokenId}) async {
  //   try {
  //     var uri = await callContract(
  //         rpcUrl: rpcUrl,
  //         contractAddress: contractAddress,
  //         functionName: 'tokenURI',
  //         params: [BigInt.parse(tokenId)]);
  //     var response = await http.get(Uri.parse(uri[0]));

  //     return _$NFTMetadataFromJson(jsonDecode(response.body));
  //   } catch (error) {
  //     return error;
  //   }
  // }
}
