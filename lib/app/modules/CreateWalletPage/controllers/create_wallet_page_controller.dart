import 'package:cryptoreliwell/app/data/Storage_data.dart';
import 'package:cryptoreliwell/app/services/storage_service.dart';
import 'package:cryptoreliwell/app/services/wallet_service.dart';
import 'package:cryptoreliwell/app/services/web3_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';

class CreateWalletPageController extends GetxController {
  final mnemonic = ''.obs;
  final address = ''.obs;
  final balance = ''.obs; // human string
  final existingPhrase = TextEditingController();
  final privateKeyImp = TextEditingController();

  late Web3Service web3;
  WalletService walletService = WalletService();
  @override
  void onInit() {
    super.onInit();
    web3 = Web3Service();
    loadFromStorage();
    // walletService.generateMnemonic1();
  }

  Future<void> createNewWallet() async {
    final m = WalletService.generateMnemonic();
    mnemonic.value = m;
    // save mnemonic encrypted later — here we store (demo) plain for simplicity
    print("My Menemonic $m");
    await StorageService.write(StorageData.PHRASE_MNEMONIC, m);
    await _deriveAndLoad(m);
  }

  //========= Import Wallet ------------=========
  Future<void> importWallet(String m) async {
    if (!WalletService.validateMnemonic(m)) throw Exception('Invalid mnemonic');
    mnemonic.value = m;
    await StorageService.write(StorageData.PHRASE_MNEMONIC, m);
    await _deriveAndLoad(m);
  }

  Future<void> _deriveAndLoad(String m) async {
    final seed = WalletService.mnemonicToSeed(m);

    final priv = WalletService.derivePrivateKey(seed, index: 0);

    final privHex = WalletService.privateKeyHex(priv);
    print("address ${priv}");
    print("private Key $privHex");
    final phrasem = await StorageService.read(StorageData.PHRASE_MNEMONIC);
    print("Phrase mnemonic $phrasem");

    final creds = EthPrivateKey.fromHex(privHex);
    final addr = await creds.extractAddress();

    address.value = addr.hex; //waller address

    final bal = await web3.getBalance(addr);
    balance.value = bal.getValueInUnit(EtherUnit.ether).toString();
  }

  Future<void> loadFromStorage() async {
    final m = await StorageService.read(StorageData.PHRASE_MNEMONIC);
    // print("Phrase mnemonic1 ${StorageData.PHRASE_MNEMONIC}");

    if (m != null) {
      await _deriveAndLoad(m);
      mnemonic.value = m;
    }
  }

  Future<String> sendEth(String toHex, double amount) async {
    final m = await StorageService.read(StorageData.PHRASE_MNEMONIC);
    // print("Phrase mnemonic ${StorageData.PHRASE_MNEMONIC}");
    if (m == null) throw Exception('No wallet');
    final seed = WalletService.mnemonicToSeed(m);
    final priv = WalletService.derivePrivateKey(seed, index: 0);
    final privHex = WalletService.privateKeyHex(priv);
    final creds = EthPrivateKey.fromHex(privHex);

    final tx = Transaction(
      to: EthereumAddress.fromHex(toHex),
      value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount),
    );

    final hash = await web3.sendTransaction(creds, tx);
    return hash;
  }
}
