part of 'welcome_bloc.dart';

sealed class WelcomeEvent {}

class DoGetWalletBalance extends WelcomeEvent {}

class DoGetFundsAvailable extends WelcomeEvent {}

class DoChangeSub extends WelcomeEvent {
  final FundEntity fund;

  DoChangeSub(this.fund);
}
