import 'package:amaris_consulting/core/config/environment_config.dart';
import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:amaris_consulting/dal/fund/domain/fund_dal.dart';
import 'package:amaris_consulting/dal/wallet/domain/wallet_dal.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<DoGetWalletBalance>(_onDoGetWallet);
    on<DoGetFundsAvailable>(_onGetFunds);
    on<DoChangeSub>(_onDoChangeSub);
    on<ClearNotification>(_onClearNotification);
  }

  // [Methods]
  Future<void> _onDoGetWallet(
    DoGetWalletBalance event,
    Emitter<WelcomeState> emit,
  ) async {
    double currentValue = WalletDal().getWalletValue();

    emit(WalletLoaded(currentValue, getCurrentWalletColor(currentValue)));
  }

  Future<void> _onGetFunds(
    DoGetFundsAvailable event,
    Emitter<WelcomeState> emit,
  ) async {
    List<FundEntity> funds = FundDal().getAvailableFunds();

    emit(WalletFundsLoaded(funds));
  }

  Future<void> _onDoChangeSub(
    DoChangeSub event,
    Emitter<WelcomeState> emit,
  ) async {
    // 1. Validate if the customer has enough money and if the operation is a subscription
    if(canOperate(event.fund, event.fund.isSubscribed!)) {

      // 2. We update the subscription value [We change subscription value]
      FundDal().updateOneFund(event.fund, !event.fund.isSubscribed!);
      
      // 2.1 Update the current wallet value
      double currentWalletValue = WalletDal().updateWalletSubscribe(event.fund.isSubscribed!, event.fund.minAmount!);

      // 3. Update button appearance [UX]
      emit(FundActionLoaded(event.fund));

      // 3.1 Update UX - Wallet balance
      emit(WalletLoaded(currentWalletValue, getCurrentWalletColor(currentWalletValue)));
    }
    else {
      // Ups! Emit error: the customer doesn't have enough money
      emit(InsufficientFundsError());
    }
  }

  Future<void> _onClearNotification(
    ClearNotification event,
    Emitter<WelcomeState> emit
  ) async {
    emit(ClearFundsError());
  }

  // [Functions]
  Color getCurrentWalletColor(double currentValue) {
    // UX connects to Wallet; Logic handled in Bloc
    if (currentValue < EnvironmentConfig.walletAtRisk) {
      return Colors.redAccent;
    } else if (currentValue < EnvironmentConfig.walletLowBalance) {
      return Colors.orangeAccent;
    } else {
      return Colors.green;
    }
  }

  bool canOperate(FundEntity currentFund, bool isSubscribed) {
    bool result = false;
    double currentBalance = WalletDal().getWalletValue();
    
    // 1. Validate if the customer has enough money and if the operation is a subscription
    result = (currentFund.minAmount! <= currentBalance || isSubscribed);

    return result;
  }
}
