part of 'welcome_bloc.dart';

sealed class WelcomeState {}

// [Life cicle]
final class WelcomeInitial extends WelcomeState {}

//[States]
final class WalletLoaded extends WelcomeState {
  final double walletCurrentValue;
  final Color walletColor;

  WalletLoaded(this.walletCurrentValue, this.walletColor);
}

final class WalletFundsLoaded extends WelcomeState {
  final List<FundEntity> funds;

  WalletFundsLoaded(this.funds);
}