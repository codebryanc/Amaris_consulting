import 'package:amaris_consulting/core/models/transaction_entity.dart';

class TransactionLocalDatasource {
  // [Properties]
  static final TransactionLocalDatasource _instance = TransactionLocalDatasource._internal();
  List<TransactionEntity> transactionList = [];
  
  // [Singleton]
  factory TransactionLocalDatasource() {
    return _instance;
  }
  
  // [Private Constructor]
  TransactionLocalDatasource._internal();
  
  // [Methods]
  void addTransactionRecord(TransactionEntity transaction) {
    transactionList.add(transaction);
  }
  
  List<TransactionEntity> getTransactions() {
    List<TransactionEntity> sortedList = List.from(transactionList);
    sortedList.sort((a, b) => (b.dateTime ?? DateTime.now()).compareTo(a.dateTime ?? DateTime.now()));
    return sortedList;
  }
}