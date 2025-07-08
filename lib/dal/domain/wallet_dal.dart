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
    return 0.0;
  }
}