import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:amaris_consulting/dal/transaction/domain/transaction_dal.dart';
import 'package:amaris_consulting/core/models/transaction_entity.dart';
import 'package:amaris_consulting/core/config/environment_config.dart';
import 'package:amaris_consulting/core/models/fund_entity.dart';
import 'package:amaris_consulting/core/models/fund_notification_method_type.dart';
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

  // Wallet
  Future<void> _onDoGetWallet(
    DoGetWalletBalance event,
    Emitter<WelcomeState> emit,
  ) async {
    double currentValue = WalletDal().getWalletValue();

    emit(WalletLoaded(currentValue, getCurrentWalletColor(currentValue)));
  }

  // Funds
  Future<void> _onGetFunds(
    DoGetFundsAvailable event,
    Emitter<WelcomeState> emit,
  ) async {
    emitWalletFundsLoaded(emit);
  }

  Future<void> _onDoChangeSub(
    DoChangeSub event,
    Emitter<WelcomeState> emit,
  ) async {
    // 1. Validate if the customer has enough money and if the operation is a subscription
    if(canOperate(event.fund, event.fund.isSubscribed!)) {

      // 2. We update the subscription value [We change subscription value]
      FundEntity currentFund = event.fund;
      currentFund.isSubscribed = !event.fund.isSubscribed!;

      // 2.1 Update Fund information
      FundDal().updateFundBySubscribed(currentFund);

      // 2.2 Update the current wallet value
      double currentWalletValue = WalletDal().updateWalletSubscribe(event.fund.isSubscribed!, event.fund.minAmount!);

      // 2.3 Save Fund transaction
      TransactionDal().addTransactionRecord(currentFund, currentWalletValue);      

      // 3. Update button appearance [UX]
      emitWalletFundsLoaded(emit);

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

  // Notifications
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
    emitWalletFundsLoaded(emit);
  }

  Future<void> _onDoChangeAllFundNotificationType(DoChangeAllFundNotificationType event, Emitter<WelcomeState> emit) async {
    // 1. Update Fund notification type to this subscribe
    FundDal().updateAllFundByNotificationType(event.messageType);

    // 2. Update button appearance [UX]
    emitWalletFundsLoaded(emit);
  }

  Future<void> _onDoClearAllFundNotificationType(DoClearAllFundNotificationType event, Emitter<WelcomeState> emit) async {
     // 1. Update Fund notification type to this subscribe
    FundDal().updateAllFundByNotificationType(null);

    // 2. Update button appearance [UX]
    emitWalletFundsLoaded(emit);
  }

  // Visibility controls
  Future<void> _onDoToggleTransactionList(DoToggleTransactionList event, Emitter<WelcomeState> emit) async {
    // Toggle visibility
    showTransactionList = !showTransactionList;

    // Emit Fund list
    emitWalletFundsLoaded(emit);
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

  Future<void> emitWalletFundsLoaded(Emitter<WelcomeState> emit) async {
    emit(WalletFundsLoaded(FundDal().getAvailableFunds(), showTransactionList, TransactionDal().getTransactions()));
  }
}
