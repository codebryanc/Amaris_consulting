import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:amaris_consulting/dal/fund/data/fund_local_datasource.dart';

class FundDal {
  // [Properties]
  static final FundDal _instance = FundDal._internal();

  // [Singleton]
  factory FundDal() {
    return _instance;
  }

  // [Private Constructor]
  FundDal._internal();

  // [Methods]
  List<FundEntity> getAvailableFunds() {
    return FundLocalDatasource().getAvailableFunds();
  }

  bool updateOneFund(FundEntity editedFund, bool isSubscribed) {
    // Update the entity information
    editedFund.isSubscribed = isSubscribed;
    
    // Apply with repository
    return FundLocalDatasource().updateFund(editedFund);
  }
}
