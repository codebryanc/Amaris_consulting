import 'dart:ui';

import 'package:amaris_consulting/bll/fund/fund_bll.dart';
import 'package:amaris_consulting/bll/wallet/wallet_bll.dart';
import 'package:amaris_consulting/core/config/environment_config.dart';
import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<DoGetWalletBalance>(_onDoGetWallet);
    on<DoGetFundsAvailable>(_onGetFunds);
  }

  // [Methods]
  Future<void> _onDoGetWallet(DoGetWalletBalance event, Emitter<WelcomeState> emit) async {
    double currentValue = WalletBll().getWalletValue();
    Color currentWalletColor = getCurrentWalletColor(currentValue);


    emit(WalletLoaded(currentValue, currentWalletColor));
  }

  Future<void> _onGetFunds(DoGetFundsAvailable event, Emitter<WelcomeState> emit) async {
    List<FundEntity> funds = FundBll().getAvailableFunds();

    emit(WalletFundsLoaded(funds));
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