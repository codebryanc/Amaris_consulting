import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:amaris_consulting/dal/fund/domain/fund_dal.dart';

class FundBll {
  // [Properties]
  static final FundBll _instance = FundBll._internal();
  
  // [Singleton]
  factory FundBll() {
    return _instance;
  }
  
  // [Private Constructor]
  FundBll._internal();
  
  // [Methods]
  List<FundEntity> getAvailableFunds() {
    return FundDal().getAvailableFunds();
  }
}