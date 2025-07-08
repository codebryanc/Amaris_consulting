import 'package:amaris_consulting/core/models/fund_category_type.dart';
import 'package:amaris_consulting/core/models/fund_notification_method_type.dart';

class FundEntity {
  FundEntity.empty();

  FundEntity({
    this.id,
    this.name,
    this.friendlyName,
    this.shortName,
    this.minAmount,
    this.category,
    this.isSubscribed,
    this.notificationMethodType
  });

  int? id;
  String? name;
  String? friendlyName;
  String? shortName;
  double? minAmount;
  FundCategoryType? category;
  bool? isSubscribed;
  FundNotificationMethodType? notificationMethodType;

  String getCategoryName() {
    switch (category) {
      case FundCategoryType.fic:
        return "FIC";
      case FundCategoryType.fpv:
        return "FPV";
      default:
        return "";
    }
  }
}
