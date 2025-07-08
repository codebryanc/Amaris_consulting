part of 'welcome_bloc.dart';

sealed class WelcomeEvent {}

class DoGetWalletBalance extends WelcomeEvent {}

class DoGetFundsAvailable extends WelcomeEvent {}

class DoChangeSub extends WelcomeEvent {
  final FundEntity fund;

  DoChangeSub(this.fund);
}

class DoClearNotification extends WelcomeEvent {}

class DoChangeFundNotificationType extends WelcomeEvent {
  final FundEntity fund;
  final FundNotificationMethodType messageType;

  DoChangeFundNotificationType(this.fund, this.messageType);
}
