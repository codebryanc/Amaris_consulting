import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:amaris_consulting/core/tools/currency_tool.dart';
import 'package:amaris_consulting/features/common/widget/loading_widget.dart';
import 'package:amaris_consulting/features/welcome/bloc/welcome_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundsWidget extends StatefulWidget {
  const FundsWidget({super.key});

  @override
  State<FundsWidget> createState() => _FundsWidgetState();
}

class _FundsWidgetState extends State<FundsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      buildWhen: (previous, current) => current is WalletFundsLoaded,
      builder: (context, state) {
        
        if(state is WalletFundsLoaded) {
          // Show all fund available
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.funds.length,
            itemBuilder: (BuildContext context, int index) {
              return getFund(state.funds[index]);
            }
          );
        }
        else {
          return LoadingWidget().getLoading();
        }

      },
    );
  }

  // [Widget]
  Widget getFund(FundEntity fund) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Name
            Row(
            children: [
              Text(fund.friendlyName ?? ''),
              const SizedBox(width: 8),
              Text(
              fund.getCategoryName(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              ),
            ],
            ),
          // Amount
          Text(
            CurrencyTool().castToCurrency(fund.minAmount ?? 0),
            style: TextStyle(fontWeight: FontWeight.bold)
          )
        ],
      ),
    );
  }
}