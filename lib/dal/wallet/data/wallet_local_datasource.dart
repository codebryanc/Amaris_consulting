class WalletLocalDatasource {
  // [Properties]
  static final WalletLocalDatasource _instance = WalletLocalDatasource._internal();
  double currentWalletValue = 100000;

  // [Singleton]
  factory WalletLocalDatasource() {
    return _instance;
  }

  // [Private Constructor]
  WalletLocalDatasource._internal();

  // [Methods]  
  double getCurrentWalletValue() {
    return currentWalletValue;
  }

  void setCurrentWalletValue(double walletValue) {
    currentWalletValue = walletValue;
  }
}