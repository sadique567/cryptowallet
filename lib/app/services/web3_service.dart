import 'package:web3dart/web3dart.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Web3Service {
  late final Web3Client _client;
  // Web3Service._(this.client);

  Web3Service(String rpcUrl) {
    _client = Web3Client(rpcUrl, http.Client());
    // return Web3Service._(c);
  }

  Future<double> getNativeCoinBal(String address) async {
    try {
      final ethAddress = EthereumAddress.fromHex(address);
      final balance = await _client.getBalance(ethAddress);
      // convert from wei to Eitherium
      return balance.getValueInUnit(EtherUnit.ether);
    } catch (e) {
      rethrow;
    }   
  }

  Future<EtherAmount> getBalance(String address) async {
    final ethAdd = EthereumAddress.fromHex(address);

    return await _client.getBalance(ethAdd);
  }

  Future<String> sendTransaction(Credentials creds, Transaction tx) async {
    return await _client.sendTransaction(creds, tx, chainId: CHAIN_ID);
  }

  void dispose() {
    _client.dispose();
  }
}
