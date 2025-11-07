import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../utils/constants.dart';

class Web3Service {
  final Web3Client client;
  Web3Service._(this.client);

  factory Web3Service() {
    final c = Web3Client(RPC_URL, Client());
    return Web3Service._(c);
  }

  Future<EtherAmount> getBalance(EthereumAddress address) async {
    return await client.getBalance(address);
  }

  Future<String> sendTransaction(Credentials creds, Transaction tx) async {
    return await client.sendTransaction(creds, tx, chainId: CHAIN_ID);
  }
}
