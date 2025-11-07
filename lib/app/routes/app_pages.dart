import 'package:get/get.dart';

import '../modules/BackupPhrasePage/bindings/backup_phrase_page_binding.dart';
import '../modules/BackupPhrasePage/views/backup_phrase_page_view.dart';
import '../modules/CreateWalletPage/bindings/create_wallet_page_binding.dart';
import '../modules/CreateWalletPage/views/create_wallet_page_view.dart';
import '../modules/HomePage/bindings/home_page_binding.dart';
import '../modules/HomePage/views/home_page_view.dart';
import '../modules/ReceivePage/bindings/receive_page_binding.dart';
import '../modules/ReceivePage/views/receive_page_view.dart';
import '../modules/SendPage/bindings/send_page_binding.dart';
import '../modules/SendPage/views/send_page_view.dart';
import '../modules/already_have_acc/bindings/already_have_acc_binding.dart';
import '../modules/already_have_acc/views/already_have_acc_view.dart';
import '../modules/genrate_phrase/bindings/genrate_phrase_binding.dart';
import '../modules/genrate_phrase/views/genrate_phrase_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/show_wallet/bindings/show_wallet_binding.dart';
import '../modules/show_wallet/views/show_wallet_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.GENRATE_PHRASE,
      page: () => const GenratePhraseView(),
      binding: GenratePhraseBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_WALLET_PAGE,
      page: () => const CreateWalletPageView(),
      binding: CreateWalletPageBinding(),
    ),
    GetPage(
      name: _Paths.BACKUP_PHRASE_PAGE,
      page: () => const BackupPhrasePageView(),
      binding: BackupPhrasePageBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.SEND_PAGE,
      page: () => const SendPageView(),
      binding: SendPageBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVE_PAGE,
      page: () => const ReceivePageView(),
      binding: ReceivePageBinding(),
    ),
    GetPage(
      name: _Paths.ALREADY_HAVE_ACC,
      page: () => const AlreadyHaveAccView(),
      binding: AlreadyHaveAccBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_WALLET,
      page: () => const ShowWalletView(),
      binding: ShowWalletBinding(),
    ),
  ];
}
