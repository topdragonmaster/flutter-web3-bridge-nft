import 'dart:async';
import 'blockchain_service.dart';
import 'package:web3dart/web3dart.dart';

const basePath = "assets/abi/";

class ContractService extends BlockchainService {
  late DeployedContract contract;

  ContractService(
      {required int chainId,
      required String rpcUrl,
      required String abi,
      required String contractAddress})
      : super(chainId: chainId, rpcUrl: rpcUrl) {
    contract = DeployedContract(ContractAbi.fromJson(abi, ''),
        EthereumAddress.fromHex(contractAddress));
  }

  Future<dynamic> callContract(
      {required String functionName, List<dynamic> params = const []}) async {
    final callFunction = contract.function(functionName);
    return await client.call(
        contract: contract, function: callFunction, params: params);
  }

  Future<String> executeContract(
      {required String privateKey,
      required String functionName,
      List<dynamic> params = const [],
      String value = "0"}) async {
    Credentials credentials = EthPrivateKey.fromHex(privateKey);
    final contractFunction = contract.function(functionName);
    return await client.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract,
          function: contractFunction,
          parameters: params,
          value: EtherAmount.fromBase10String(EtherUnit.wei, value)),
      chainId: chainId,
    );
  }
}
