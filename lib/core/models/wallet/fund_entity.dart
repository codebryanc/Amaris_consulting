import 'package:amaris_consulting/core/models/wallet/fund_category_type.dart';

class FundEntity {
  FundEntity.empty();

  FundEntity({
    this.id,
    this.name,
    this.friendlyName,
    this.minAmount,
    this.category,
  });

  int? id;
  String? name;
  String? friendlyName;
  double? minAmount;
  FundCategoryType? category;

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