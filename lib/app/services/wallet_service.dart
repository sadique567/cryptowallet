import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:convert/convert.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  /// ✅ Generate 12-word mnemonic
  static String generateMnemonic() => bip39.generateMnemonic();

  /// ✅ Validate mnemonic
  static bool validateMnemonic(String mnemonic) =>
      bip39.validateMnemonic(mnemonic);

  /// ✅ Convert mnemonic to seed bytes
  static Uint8List mnemonicToSeed(String mnemonic) =>
      bip39.mnemonicToSeed(mnemonic);

  /// ✅ Derive EVM wallet (Ethereum, BNB, Polygon)
  static Map<String, dynamic> getEvmWallet(Uint8List seed) {
    // BIP44 Ethereum derivation path
    final path = "m/44'/60'/0'/0/0";
    final root = bip32.BIP32.fromSeed(seed);
    final child = root.derivePath(path);

    // Get private key  
    final privateKey = HEX.encode(child.privateKey!);
    final credentials = EthPrivateKey.fromHex(privateKey);
    final address = credentials.address.hex;
    print("service address : $address");
    return {"address": address, "privateKey": privateKey};
  }
}
