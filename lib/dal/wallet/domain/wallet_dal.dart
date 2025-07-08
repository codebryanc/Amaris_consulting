import 'package:amaris_consulting/dal/wallet/data/wallet_local_datasource.dart';

class WalletDal {
  // [Properties]
  static final WalletDal _instance = WalletDal._internal();

  // [Singleton]
  factory WalletDal() {
    return _instance;
  }

  // [Private Constructor]
  WalletDal._internal();

  // [Methods]
  double getWalletValue() {
    return WalletLocalDatasource().getCurrentWalletValue();
  }

  double updateWalletSubscribe(bool isSubscribedAction, double subscription) {
    double walletValue = getWalletValue();

    if(isSubscribedAction) {
      WalletLocalDatasource().setCurrentWalletValue(walletValue - subscription);
    }
    else {
      WalletLocalDatasource().setCurrentWalletValue(walletValue + subscription);
    }

    // Read the current balance again
    return getWalletValue();
  }
}
