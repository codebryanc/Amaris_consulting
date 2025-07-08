import 'package:amaris_consulting/dal/domain/wallet_dal.dart';

class WalletBll {
  // [Properties]
  static final WalletBll _instance = WalletBll._internal();
  
  // [Singleton]
  factory WalletBll() {
    return _instance;
  }
  
  // [Private Constructor]
  WalletBll._internal();

  double getWalletValue() {
    return WalletDal().getWalletValue();
  }

  void setWalletValue(double walletValue) {
    WalletDal().setWalletValue(walletValue);
  } 
}