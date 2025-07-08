class TransactionEntity {
  TransactionEntity.empty();

  TransactionEntity({
    this.dateTime,
    this.friendlyName,
    this.shortName,
    this.minAmount,
    this.category,
    this.isSubscribed,
    this.walletValue
  });

  DateTime? dateTime;
  String? friendlyName;
  String? shortName;
  double? minAmount;
  String? category;
  bool? isSubscribed;
  double? walletValue;
}