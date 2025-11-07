import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:web3dart/web3dart.dart' as hex;

class GenratePhraseController extends GetxController {
  //TODO: Implement GenratePhraseController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    createWallet();
  }

  void createWallet() {
    //Genrate 12 word phrase
    final mnemonic = bip39.generateMnemonic();
    print("menemonic $mnemonic");

    // velidate
    final isValid = bip39.validateMnemonic(mnemonic);
    print("isValid $isValid");

    //convert to seed
    final seed = bip39.mnemonicToSeed(mnemonic);
    
    print("Seed : ${seed.length} ${seed.sublist(0, 16)}"); //showing first byte

    deriveEthAddress(seed);
  }

  void deriveEthAddress(Uint8List seed) {
    final root = bip32.BIP32.fromSeed(seed);
    final child = root.derivePath("m/44'/60'/0'/0/0");

    final privateKey = child.privateKey!;
    print("Private Key: $privateKey ${hex.encode(privateKey)}");
  }
}
