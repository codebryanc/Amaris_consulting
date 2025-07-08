import 'package:intl/intl.dart';

class CurrencyTool {
  // [Properties]
  static final CurrencyTool _instance = CurrencyTool._internal();
  
  // [Singleton]
  factory CurrencyTool() {
    return _instance;
  }
  
  // [Private Constructor]
  CurrencyTool._internal();

  // [Methods] 
  String castToCurrency(double value) {
    final format = NumberFormat.currency(symbol: '\$', decimalDigits: 0, locale: 'es_ES', customPattern: '¤ #,##0');
    
    return format.format(value);
  }
}