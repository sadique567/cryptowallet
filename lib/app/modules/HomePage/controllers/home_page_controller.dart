import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptoreliwell/app/api/api_path.dart';
import 'package:cryptoreliwell/app/data/Storage_data.dart';
import 'package:cryptoreliwell/app/services/storage_service.dart';
import 'package:cryptoreliwell/app/utils/constants.dart';

import 'package:get/get.dart';
import 'package:cryptoreliwell/app/services/wallet_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomePageController extends GetxController {
  RxList<Map<String, dynamic>> coins = <Map<String, dynamic>>[].obs;
  late Uint8List seed;
  final isVisible = true.obs;
  String mnemonic = '';
  String ethAddress = '';
  Stream<double>? totalBalance;

  @override
  void onInit() {
    super.onInit();
    loadWallets();
  }

  // Stream<double> getTotalBalance() async* {
  //  coins.forEach((ttlAmt){
  // ttlAmt.forEach(action)
  //  }) ;
  // }

  Future<void> loadWallets() async {
    // ⚠ Replace with your saved mnemonic from secure storage
    mnemonic = (await StorageService.read(StorageData.PHRASE_MNEMONIC))!;

    seed = WalletService.mnemonicToSeed(mnemonic);
    ethAddress = WalletService.getEvmWallet(seed)['address'];
    final ethBalance = await fetchBalance(RPC_URL, ethAddress);
    final bnbBalance = await fetchBalance(BNB_RPC_URL, ethAddress);
    final polBalance = await fetchBalance(POL_RPC_URL, ethAddress);
    final arbBalance = await fetchBalance(ARB_RPC_URL, ethAddress);
    // ----------------------

    // final ethBalance = await fetchBalance(RPC_URL, ethAddress);
    // Add EVM-based wallets

    coins.add({
      'url': "https://cdn-icons-png.flaticon.com/512/14446/14446160.png",
      'name': 'Ethereum',
      'symbol': 'ETH',
      'current_price': getPriceStream("ETH"),
      'address': ethAddress,
      'balance': ethBalance,
      "total_usdt":
          // double.parse('${getPriceStream("ETH")}') * ethBalance,
          balanceUSDT(getPriceStream("ETH"), ethBalance),
    });

    coins.add({
      'url':
          "https://assets.streamlinehq.com/image/private/w_300,h_300,ar_1/f_auto/v1/icons/vectors/bnb-2c9adc7qw85po528q8y3b.png/bnb-tss7lyzvhxyjfc9ivae0l.png?_a=DATAg1AAZAA0",

      'name': 'BNB Smart Chain',
      'symbol': 'BNB',
      'current_price': getPriceStream("BNB"),
      'address': WalletService.getEvmWallet(seed)['address'],
      'balance': bnbBalance,
      "total_usdt": balanceUSDT(getPriceStream("BNB"), ethBalance),
    });

    coins.add({
      'url':
          "https://w7.pngwing.com/pngs/48/858/png-transparent-polygon-crypto-polygon-logo-polygon-coin-polygon-sign-polygon-symbol-polygon-3d-icon-thumbnail.png",

      'name': 'Polygon',
      'symbol': 'POL',
      'current_price': getPriceStream("POL"),
      'address': WalletService.getEvmWallet(seed)['address'],
      'balance': polBalance,
      "total_usdt": balanceUSDT(getPriceStream("POL"), ethBalance),
    });

    coins.add({
      'url':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfDySPKR3Yj-wBY3VbDmQhI6RrFn49tzr-HA&s",

      'name': 'Arbitrum',
      'symbol': 'ARB',
      'current_price': getPriceStream("ARB"),
      'address': WalletService.getEvmWallet(seed)['address'],
      'balance': arbBalance,
      "total_usdt": balanceUSDT(getPriceStream("ARB"), ethBalance),
    });
  }

  Future<String> getCurrentPrice(String coinName) async {
    String currency_usdt = "USDT";
    String url = "$CUREENT_PRICE$coinName$currency_usdt";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final price = data['price'];
      print('price====>$price');
      return price.toString();
    } else {
      print("Failed to load data");
      return "0";
    }
  }

  Stream<double> getPriceStream(String coinSym) async* {
    while (true) {
      final priceStr = await getCurrentPrice(coinSym);
      final price = double.tryParse(priceStr) ?? 0.0;

      yield price;
      // await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  // -----------FETCH BALANCE ------

  Future<double> fetchBalance(String rpc_url, String address) async {
    final Web3Client client = Web3Client(rpc_url, Client());

    final ethAddress = EthereumAddress.fromHex(address);
    final balance = await client.getBalance(ethAddress);
    print("ETH : $ethAddress");
    print("balance : $balance");
    print("Client : $client");
    // Wei -> Ether convert
    return balance.getValueInUnit(EtherUnit.ether);
  }

  // -----------wallet balance Quantity in to USDT ------
  Stream<double> balanceUSDT(Stream<double> currentPrice, double qty) async* {
    // final totalUSDT = currentPrice * qty;
    await for (final price in currentPrice) {
      yield price * qty;
    }
  }
}

// tornado consider swear fringe mutual vocal pistol furnace valid amazing chef among
