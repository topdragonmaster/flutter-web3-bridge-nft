import 'dart:async';
import 'contract_service.dart';
import 'package:web3dart/web3dart.dart';

class NativeProxyService extends ContractService {
  NativeProxyService(
      {required int chainId,
      required String rpcUrl,
      required String abi,
      required String contractAddress})
      : super(
            chainId: chainId,
            rpcUrl: rpcUrl,
            abi: abi,
            contractAddress: contractAddress);

  Future<String> proxy(
      {required String privateKey,
      required String to,
      required String amount}) async {
    Credentials credentials = EthPrivateKey.fromHex(privateKey);

    var balance = await super.getBalance(address: credentials.address.hex);
    if (BigInt.from(balance) < BigInt.parse(amount)) {
      throw Exception("Insufficent Fund");
    }

    return await super.executeContract(
        privateKey: privateKey,
        functionName: 'proxy',
        params: [EthereumAddress.fromHex(to)],
        value: amount);
  }
}
