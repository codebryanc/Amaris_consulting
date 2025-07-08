import 'package:amaris_consulting/core/models/wallet/fund_category_type.dart';

class FundEntity {
  FundEntity.empty();

  FundEntity({
    this.id,
    this.name,
    this.friendlyName,
    this.shortName,
    this.minAmount,
    this.category,
    this.isSubscribed
  });

  int? id;
  String? name;
  String? friendlyName;
  String? shortName;
  double? minAmount;
  FundCategoryType? category;
  bool? isSubscribed;

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