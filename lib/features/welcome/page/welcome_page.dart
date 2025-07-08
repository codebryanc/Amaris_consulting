import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:amaris_consulting/core/tools/currency_tool.dart';
import 'package:amaris_consulting/features/common/widget/loading_widget.dart';
import 'package:amaris_consulting/features/common/widget/notification_widget.dart';
import 'package:amaris_consulting/features/welcome/widget/funds_widget.dart';
import 'package:amaris_consulting/features/welcome/bloc/welcome_bloc.dart';
import 'package:amaris_consulting/features/welcome/widget/fund_notification_type_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    // Current wallet balance
    context.read<WelcomeBloc>().add(DoGetWalletBalance());

    // Get Fund available
    context.read<WelcomeBloc>().add(DoGetFundsAvailable());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Expanded(
          child: Row(
            children: [
              // Image
              Image.asset('lib/core/assets/logo.png', height: 45),

              // Your current wallet
              const Spacer(),
              // Wallet value
              showCurrentWalletValue(context),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Notification widget for insufficient funds
          BlocListener<WelcomeBloc, WelcomeState>(
            listenWhen: (previous, current) => current is WalletAskNotificationMethod,
            listener: (context, state) {
              if(state is WalletAskNotificationMethod) {
                FundNotificationTypeWidget().showDialogNotificationMethod(context, state.fund);
              }
            },
            child: BlocBuilder<WelcomeBloc, WelcomeState>(
              buildWhen: (previous, current) =>
                  current is InsufficientFundsError ||
                  current is ClearFundsError,
              builder: (context, state) {
                if (state is InsufficientFundsError) {
                  return NotificationWidget.insufficientFunds(
                    onClose: () {
                      context.read<WelcomeBloc>().add(DoClearNotification());
                    },
                  );
                } else if (state is ClearFundsError) {
                  return const SizedBox.shrink();
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          // Welcome title
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "Bienvenido",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 32,
              left: 4,
              right: 4,
            ),
            child: Text(
              "Acá encuentras un listado sobre el manejo de fondos (FPV/FIC) para clientes BTG",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          // Fund list
          FundsWidget(),
        ],
      ),
    );
  }

  // [Methods]
  Widget showCurrentWalletValue(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      buildWhen: (previous, current) => current is WalletLoaded,
      builder: (context, state) {
        if (state is WalletLoaded) {
          return Text(
            CurrencyTool().castToCurrency(state.walletCurrentValue),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: state.walletColor,
            ),
          );
        } else {
          return LoadingWidget().getLoading();
        }
      },
    );
  }
}
