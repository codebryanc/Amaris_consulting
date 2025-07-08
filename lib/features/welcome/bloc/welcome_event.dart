part of 'welcome_bloc.dart';

sealed class WelcomeEvent {}

class DoGetWalletBalance extends WelcomeEvent {}

class DoGetFundsAvailable extends WelcomeEvent {}