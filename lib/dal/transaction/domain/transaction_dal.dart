import 'package:amaris_consulting/core/models/fund_entity.dart';
import 'package:amaris_consulting/core/models/transaction_entity.dart';
import 'package:amaris_consulting/dal/transaction/data/transaction_local_datasource.dart';

class TransactionDal {
  // [Properties]
  static final TransactionDal _instance = TransactionDal._internal();
  
  // [Singleton]
  factory TransactionDal() {
    return _instance;
  }
  
  // [Private Constructor]
  TransactionDal._internal();
  
  // [Methods]
  void addTransactionRecord(FundEntity fund, double currentWalletValue) {
    
    TransactionEntity currentTransaction = TransactionEntity(
      dateTime: DateTime.now(),
      friendlyName: fund.friendlyName ?? '',
      shortName: fund.shortName,
      minAmount: fund.minAmount,
      category: fund.getCategoryName(),
      isSubscribed: fund.isSubscribed,
      walletValue: currentWalletValue,
    );

    TransactionLocalDatasource().addTransactionRecord(currentTransaction);
  }
  
  List<TransactionEntity> getTransactions() {
    List<TransactionEntity> transactions = TransactionLocalDatasource().getTransactions();
    return transactions;
  }
}