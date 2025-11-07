import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  // Generate mnemonic (12 words)
  static String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  // Validate mnemonic
  static bool validateMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }

  // Convert mnemonic to seed bytes
  static Uint8List mnemonicToSeed(String mnemonic) {
    return bip39.mnemonicToSeed(mnemonic);
  }

  // Derive private key bytes for Ethereum using BIP-44 path m/44'/60'/0'/0/index
  static Uint8List derivePrivateKey(Uint8List seed, {int index = 0}) {
    final root = bip32.BIP32.fromSeed(seed);
    final path = "m/44'/60'/0'/0/$index";

    final child = root.derivePath(path);
    final priv = child.privateKey!; // 32 bytes
    return priv;
  }

  static String privateKeyHex(Uint8List privateKey) {
    return hex.encode(privateKey);
  }

  String phrase = '';
  // Generate mnemonic (12 words)
  void generateMnemonic1() async {
    // genrate Pharase
    phrase = bip39.generateMnemonic();
    await createETH();
  }

  Future<void> createETH() async {
    final seed = bip39.mnemonicToSeed(phrase);
    final node = bip32.BIP32.fromSeed(Uint8List.fromList(seed));
    final child = node.derivePath("m/44'/60'/0'/0/0");
    final privateKeyHex = HEX.encode(child.privateKey!);
    final credentials = EthPrivateKey.fromHex(privateKeyHex);
    debugPrint('phrase : -> $phrase');
    debugPrint('address :-> ${credentials.address.hex}');
    debugPrint('Privatekey :-> $privateKeyHex');
  }

  Future<void> createBTC() async {
    final seed = bip39.mnemonicToSeed(phrase); // genrate seed
    final node = bip32.BIP32.fromSeed(Uint8List.fromList(seed));
    final child = node.derivePath("m/84'/0'/0'/0/0");
    final privateKeyHexBTC = HEX.encode(child.privateKey!);
    // final credentials =
  }
}


/*
final child = node.derivePath("m/44'/60'/0'/0/0");
      final privateKeyHex = HEX.encode(child.privateKey!);
      final credentials = EthPrivateKey.fromHex(privateKeyHex);
*/