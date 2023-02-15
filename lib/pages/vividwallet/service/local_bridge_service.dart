import 'dart:async';
import 'dart:typed_data';
import 'contract_service.dart';
import "package:hex/hex.dart";

class LocalBridgeService extends ContractService {
  LocalBridgeService(
      {required int chainId,
      required String rpcUrl,
      required String abi,
      required String contractAddress})
      : super(
            chainId: chainId,
            rpcUrl: rpcUrl,
            abi: abi,
            contractAddress: contractAddress);

  Future<bool> isDepositBridged({required String hash}) async {
    return (await super.callContract(
        functionName: "transfers",
        params: [Uint8List.fromList(HEX.decode(hash))]))[0];
  }
}
