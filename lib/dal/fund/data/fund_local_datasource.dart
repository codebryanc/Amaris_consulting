import 'package:amaris_consulting/core/models/wallet/fund_category_type.dart';
import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';

class FundLocalDatasource {
  // [Properties]
  static final FundLocalDatasource _instance = FundLocalDatasource._internal();
  
  
  // [Singleton]
  factory FundLocalDatasource() {
    return _instance;
  }
  
  // [Private Constructor]
  FundLocalDatasource._internal();
  
  // [Methods]
  List<FundEntity> getAvailableFunds() {
    return _funds;
  }

  final List<FundEntity> _funds = [
    // 1
    FundEntity(
      id: 1,
      name: 'FPV_BTG_PACTUAL_RECAUDADORA',
      friendlyName: 'BTG Pactual Recaudadora',
      minAmount: 75000,
      category: FundCategoryType.fpv,
    ),
    // 2
    FundEntity(
      id: 2,
      name: 'FPV_BTG_PACTUAL_ECOPETROL',
      friendlyName: 'BTG Pactual Ecopetrol',
      minAmount: 125000,
      category: FundCategoryType.fpv,
    ),
    // 3
    FundEntity(
      id: 3,
      name: 'DEUDAPRIVADA',
      friendlyName: 'Deuda Privada',
      minAmount: 50000,
      category: FundCategoryType.fic,
    ),
    // 4
    FundEntity(
      id: 4,
      name: 'FDO-ACCIONES',
      friendlyName: 'Fondo de Acciones',
      minAmount: 250000,
      category: FundCategoryType.fic,
    ),
    // 5
    FundEntity(
      id: 5,
      name: 'FPV_BTG_PACTUAL_DINAMICA',
      friendlyName: 'BTG Pactual Dinámica',
      minAmount: 100000,
      category: FundCategoryType.fpv,
    ),
  ];

}
