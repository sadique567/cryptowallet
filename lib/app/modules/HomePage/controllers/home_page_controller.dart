import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:cryptoreliwell/app/services/wallet_service.dart';

class HomePageController extends GetxController {
  RxList<Map<String, dynamic>> coins = <Map<String, dynamic>>[].obs;
  late Uint8List seed;
  final isVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadWallets();
  }

  Future<void> _loadWallets() async {
    // ⚠ Replace with your saved mnemonic from secure storage
    const mnemonic = "your twelve word mnemonic here";

    seed = WalletService.mnemonicToSeed(mnemonic);

    // Add EVM-based wallets
    coins.add({
      'url': "https://cdn-icons-png.flaticon.com/512/14446/14446160.png",
      'name': 'Ethereum',
      'symbol': 'ETH',
      'address': WalletService.getEvmWallet(seed, index: 0)['address'],
    });

    coins.add({
      'url':
          "https://assets.streamlinehq.com/image/private/w_300,h_300,ar_1/f_auto/v1/icons/vectors/bnb-2c9adc7qw85po528q8y3b.png/bnb-tss7lyzvhxyjfc9ivae0l.png?_a=DATAg1AAZAA0",

      'name': 'BNB Smart Chain',
      'symbol': 'BNB',
      'address': WalletService.getEvmWallet(seed, index: 1)['address'],
    });

    coins.add({
      'url':
          "https://w7.pngwing.com/pngs/48/858/png-transparent-polygon-crypto-polygon-logo-polygon-coin-polygon-sign-polygon-symbol-polygon-3d-icon-thumbnail.png",

      'name': 'Polygon',
      'symbol': 'POL',
      'address': WalletService.getEvmWallet(seed, index: 2)['address'],
    });

    coins.add({
      'url':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfDySPKR3Yj-wBY3VbDmQhI6RrFn49tzr-HA&s",

      'name': 'Arbitrum',
      'symbol': 'ARB',
      'address': WalletService.getEvmWallet(seed, index: 3)['address'],
    });
  }
}
