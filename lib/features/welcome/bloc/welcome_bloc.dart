import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:amaris_consulting/core/config/environment_config.dart';
import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:amaris_consulting/core/models/wallet/fund_notification_method_type.dart';
import 'package:amaris_consulting/dal/fund/domain/fund_dal.dart';
import 'package:amaris_consulting/dal/wallet/domain/wallet_dal.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  // [properties]
  static bool showTransactionList = true;

  WelcomeBloc() : super(WelcomeInitial()) {
    on<DoGetWalletBalance>(_onDoGetWallet);
    on<DoGetFundsAvailable>(_onGetFunds);
    on<DoChangeSub>(_onDoChangeSub);
    on<DoClearNotification>(_onClearNotification);
    on<DoChangeFundNotificationType>(_onDoChangeFundNotificationType);
    on<DoChangeAllFundNotificationType>(_onDoChangeAllFundNotificationType);
    on<DoClearAllFundNotificationType>(_onDoClearAllFundNotificationType);
    on<DoToggleTransactionList>(_onDoToggleTransactionList);
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
    emit(WalletFundsLoaded(FundDal().getAvailableFunds(), showTransactionList));
  }

  Future<void> _onDoChangeSub(
    DoChangeSub event,
    Emitter<WelcomeState> emit,
  ) async {
    // 1. Validate if the customer has enough money and if the operation is a subscription
    if(canOperate(event.fund, event.fund.isSubscribed!)) {

      // 2. We update the subscription value [We change subscription value]
      FundDal().updateFundBySubscribed(event.fund, !event.fund.isSubscribed!);
      
      // 2.1 Update the current wallet value
      double currentWalletValue = WalletDal().updateWalletSubscribe(event.fund.isSubscribed!, event.fund.minAmount!);

      // 3. Update button appearance [UX]
      emit(WalletFundsLoaded(FundDal().getAvailableFunds(), showTransactionList));

      // 3.1 Update UX - Wallet balance
      emit(WalletLoaded(currentWalletValue, getCurrentWalletColor(currentWalletValue)));
      
      // 4 Request notification type
      if(event.fund.notificationMethodType == null) {
        // Please choose a Notification method
        emit(WalletAskNotificationMethod(event.fund));
      }
    }
    else {
      // Ups! Emit error: the customer doesn't have enough money
      emit(InsufficientFundsError());
    }
  }

  Future<void> _onClearNotification(
    DoClearNotification event,
    Emitter<WelcomeState> emit
  ) async {
    emit(ClearFundsError());
  }

  Future<void> _onDoChangeFundNotificationType(DoChangeFundNotificationType event, Emitter<WelcomeState> emit) async {
    // 1. Update Fund notification type to this subscribe
    FundDal().updateFundByNotificationType(event.fund, event.messageType);

    // 2. Update button appearance [UX]
    emit(WalletFundsLoaded(FundDal().getAvailableFunds(), showTransactionList));
  }

  Future<void> _onDoChangeAllFundNotificationType(DoChangeAllFundNotificationType event, Emitter<WelcomeState> emit) async {
    // 1. Update Fund notification type to this subscribe
    FundDal().updateAllFundByNotificationType(event.messageType);

    // 2. Update button appearance [UX]
    emit(WalletFundsLoaded(FundDal().getAvailableFunds(), showTransactionList));
  }

  Future<void> _onDoClearAllFundNotificationType(DoClearAllFundNotificationType event, Emitter<WelcomeState> emit) async {
     // 1. Update Fund notification type to this subscribe
    FundDal().updateAllFundByNotificationType(null);

    // 2. Update button appearance [UX]
    emit(WalletFundsLoaded(FundDal().getAvailableFunds(), showTransactionList));
  }

  Future<void> _onDoToggleTransactionList(DoToggleTransactionList event, Emitter<WelcomeState> emit) async {
    showTransactionList = !showTransactionList;

    emit(WalletFundsLoaded(FundDal().getAvailableFunds(), showTransactionList));
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
