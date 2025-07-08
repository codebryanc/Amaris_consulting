import 'dart:ui';

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
  }

  // [Methods]
  Future<void> _onDoGetWallet(DoGetWalletBalance event, Emitter<WelcomeState> emit) async {
    double currentValue = WalletDal().getWalletValue();

    emit(WalletLoaded(currentValue, getCurrentWalletColor(currentValue)));
  }

  Future<void> _onGetFunds(DoGetFundsAvailable event, Emitter<WelcomeState> emit) async {
    List<FundEntity> funds = FundDal().getAvailableFunds();

    emit(WalletFundsLoaded(funds));
  }

  Future<void> _onDoChangeSub(DoChangeSub event, Emitter<WelcomeState> emit) async {
    double initWalletValue = WalletDal().getWalletValue();
    bool isSubscribedAction = event.fund.isSubscribed!;

     // 1. Validate if the customer has enough money
     if(event.fund.minAmount! <= initWalletValue) {
      
      // 2. We update the subscription value
      event.fund.isSubscribed = !event.fund.isSubscribed! ;
      FundDal().updateOneFund(event.fund);
      
      // 2.1 Update the current wallet value
      if(isSubscribedAction == false) {
        WalletDal().updateWalletAfterSubscribe(event.fund.minAmount!);
      }
      else {
        WalletDal().updateWalletAfterCancellation(event.fund.minAmount!);
      }

      // 2.3 Read wallet result
      double currentWalletValue = WalletDal().getWalletValue();
      
      // 3. Update UX - Fund action
      emit(FundActionLoaded(event.fund));

      // 3.1 Update UX - Wallet balance
      emit(WalletLoaded(currentWalletValue, getCurrentWalletColor(currentWalletValue)));
     }
     else {
      // Ups! Emit error: the customer doesn't have enough money
     }
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
 
}