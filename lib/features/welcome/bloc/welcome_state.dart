part of 'welcome_bloc.dart';

sealed class WelcomeState {}

// [Life cicle]
final class WelcomeInitial extends WelcomeState {}

//[States]
final class WalletLoaded extends WelcomeState {
  final double walletCurrentValue;

  WalletLoaded(this.walletCurrentValue);
}