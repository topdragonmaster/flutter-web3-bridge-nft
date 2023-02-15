import 'dart:async';
import "package:hex/hex.dart";
import 'dart:typed_data';
import 'contract_service.dart';

class RemoteBridgeService extends ContractService {
  RemoteBridgeService(
      {required int chainId,
      required String rpcUrl,
      required String abi,
      required String contractAddress})
      : super(
            chainId: chainId,
            rpcUrl: rpcUrl,
            abi: abi,
            contractAddress: contractAddress);

  Future<dynamic> getTransfer({required String hash}) async {
    return (await super.callContract(
        functionName: "transfers",
        params: [Uint8List.fromList(HEX.decode(hash))]))[0];
  }
}
