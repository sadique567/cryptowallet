import 'package:cryptoreliwell/app/data/Storage_data.dart';
import 'package:cryptoreliwell/app/services/storage_service.dart';
import 'package:cryptoreliwell/app/services/wallet_service.dart';
import 'package:cryptoreliwell/app/services/web3_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';

class CreateWalletPageController extends GetxController {
  // 🔹 Reactive states
  final mnemonic = ''.obs;
  final address = ''.obs;
  final balance = ''.obs;

  // 🔹 Input controllers
  final existingPhrase = TextEditingController();
  final privateKeyImp = TextEditingController();

  // 🔹 Services
  late final Web3Service web3;
  final WalletService walletService = WalletService();

  @override
  void onInit() {
    super.onInit();
    web3 = Web3Service();
    _loadFromStorage();
  }

  // =========================================
  // 🔸 1. Create new wallet (generate mnemonic)
  // =========================================
  Future<void> createNewWallet() async {
    final m = WalletService.generateMnemonic();
    mnemonic.value = m;

    debugPrint("🧩 Generated Mnemonic: $m");

    await StorageService.write(StorageData.PHRASE_MNEMONIC, m);
    await _deriveAndLoad(m);
  }

  // =========================================
  // 🔸 2. Import wallet from mnemonic
  // =========================================
  Future<void> importWallet(String m) async {
    if (!WalletService.validateMnemonic(m)) {
      throw Exception('❌ Invalid mnemonic phrase!');
    }

    mnemonic.value = m;
    await StorageService.write(StorageData.PHRASE_MNEMONIC, m);
    await _deriveAndLoad(m);
  }

  // =========================================
  // 🔸 3. Derive private key + address from mnemonic
  // =========================================
  Future<void> _deriveAndLoad(String m) async {
    try {
      final seed = WalletService.mnemonicToSeed(m);
      final wallet = WalletService.getEvmWallet(seed, index: 0);

      final privateKey = wallet["privateKey"];
      final walletAddress = wallet["address"];

      debugPrint("🔑 Private Key: $privateKey");
      debugPrint("🏦 Address: $walletAddress");

      address.value = walletAddress;

      // Load ETH balance from RPC
      final ethAddress = EthereumAddress.fromHex(walletAddress);
      final bal = await web3.getBalance(ethAddress);

      balance.value = bal.getValueInUnit(EtherUnit.ether).toString();
    } catch (e) {
      debugPrint("⚠️ Error while deriving wallet: $e");
    }
  }

  // =========================================
  // 🔸 4. Load wallet if mnemonic is saved locally
  // =========================================
  Future<void> _loadFromStorage() async {
    final m = await StorageService.read(StorageData.PHRASE_MNEMONIC);
    if (m != null && m.isNotEmpty) {
      mnemonic.value = m;
      await _deriveAndLoad(m);
    }
  }

  // =========================================
  // 🔸 5. Send ETH to another wallet
  // =========================================
  Future<String> sendEth(String toHex, double amount) async {
    try {
      final m = await StorageService.read(StorageData.PHRASE_MNEMONIC);
      if (m == null) throw Exception('⚠️ No wallet found in storage.');

      final seed = WalletService.mnemonicToSeed(m);
      final wallet = WalletService.getEvmWallet(seed, index: 0);
      final creds = EthPrivateKey.fromHex(wallet["privateKey"]);

      final tx = Transaction(
        to: EthereumAddress.fromHex(toHex),
        value: EtherAmount.fromUnitAndValue(
          EtherUnit.ether,
          (amount * 1e18).toInt(), // Convert ETH → Wei
        ),
      );

      final hash = await web3.sendTransaction(creds, tx);
      debugPrint("✅ Transaction sent: $hash");
      return hash;
    } catch (e) {
      debugPrint("❌ Error sending ETH: $e");
      rethrow;
    }
  }
}
