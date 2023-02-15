import 'dart:async';
import 'contract_service.dart';
import 'package:web3dart/web3dart.dart';

class VividTokenService extends ContractService {
  VividTokenService(
      {required int chainId,
      required String rpcUrl,
      required String abi,
      required String contractAddress})
      : super(
            chainId: chainId,
            rpcUrl: rpcUrl,
            abi: abi,
            contractAddress: contractAddress);

  Future<BigInt> getTokenBalance({required String address}) async {
    return (await super.callContract(
        functionName: "balanceOf",
        params: [EthereumAddress.fromHex(address)]))[0];
  }

  Future<String> transfer(
      {required String privateKey,
      required String to,
      required String amount}) async {
    Credentials credentials = EthPrivateKey.fromHex(privateKey);

    var balance = await getTokenBalance(address: credentials.address.hex);
    if (balance < BigInt.parse(amount)) throw Exception("Insufficent Balance");

    return await super.executeContract(
        privateKey: privateKey,
        functionName: 'transfer',
        params: [EthereumAddress.fromHex(to), BigInt.parse(amount)]);
  }
}
