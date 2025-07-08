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

  void updateWalletAfterSubscribe(double subscription) {
    double walletValue = getWalletValue();

    WalletLocalDatasource().setCurrentWalletValue(walletValue - subscription);
  } 

  void updateWalletAfterCancellation(double cancelValue) {
    double walletValue = getWalletValue();

    WalletLocalDatasource().setCurrentWalletValue(walletValue + cancelValue);
  } 
}