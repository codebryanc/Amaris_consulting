import 'package:amaris_consulting/core/models/fund_entity.dart';
import 'package:amaris_consulting/core/models/fund_notification_method_type.dart';
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

  bool updateFundBySubscribed(FundEntity editedFund) {
    // Apply with repository
    return FundLocalDatasource().updateFund(editedFund);
  }

  bool updateFundByNotificationType(FundEntity editedFund, FundNotificationMethodType type) {
    // Update the entity information
    editedFund.notificationMethodType = type;
    
    // Apply with repository
    return FundLocalDatasource().updateFund(editedFund);
  }

  bool updateAllFundByNotificationType(FundNotificationMethodType? type) {
    // Apply with repository
    return FundLocalDatasource().editAllFund(type);
  }
}
