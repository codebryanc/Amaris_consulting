import 'package:amaris_consulting/core/config/environment_config.dart';
import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:amaris_consulting/core/models/wallet/fund_notification_method_type.dart';
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
        if (state is WalletFundsLoaded) {
          // Show all fund available
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.funds.length,
            itemBuilder: (BuildContext context, int index) {
              return getFund(state.funds[index]);
            },
          );
        } else {
          return LoadingWidget().getLoading();
        }
      },
    );
  }

  // [Widget]
  Widget getFund(FundEntity fund) {
    bool thereAreSpace = thereAreWidthSpace();
    IconData currentNotificationIcon = (fund.notificationMethodType == null) ? Icons.notifications_off_outlined : 
      (fund.notificationMethodType! == FundNotificationMethodType.email ? Icons.mark_email_unread_outlined : Icons.sms_outlined);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: thereAreSpace ? 45 : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Name
          SizedBox(
            width: thereAreSpace ? 250 : 140,
            child: Row(
              children: [
                // Name
                Text(
                  thereAreSpace ?
                    (fund.friendlyName ?? '')
                  : (fund.shortName ?? ''),
                ),
                const SizedBox(width: 4),
                // Category
                Visibility(
                  visible: thereAreSpace,
                  child: Text(
                    fund.getCategoryName(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Amount
          SizedBox(
            width: 75,
            child: Text(
              CurrencyTool().castToCurrency(fund.minAmount ?? 0),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Group by actions and icon info          
          SizedBox(
            width: 200,
            child: Row(
              children: [
                // Action
                ElevatedButton.icon(
                  onPressed: () {
                    // Change subscription [1|0]
                    context.read<WelcomeBloc>().add(DoChangeSub(fund));
                  },
                  icon: Icon(
                    fund.isSubscribed! ? Icons.cancel : Icons.check_circle,
                    color: Colors.white,
                  ),
                  label: Visibility(
                    visible: thereAreSpace,
                    child: Text(
                      fund.isSubscribed! ? "Cancelar" : "Suscribirse",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fund.isSubscribed!
                        ? Colors.red
                        : const Color.fromARGB(255, 7, 119, 212),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 2,
                  ),
                ),
                const SizedBox(width: 4),
                // Notification delivery method [SMS, Email]
                Icon(currentNotificationIcon),
              ]
            )
          ),
        ],
      ),
    );
  }

  // [Functions]
  bool thereAreWidthSpace() {
    final currentWidth = MediaQuery.of(context).size.width;

    if (currentWidth < EnvironmentConfig.minWindowSpace) {
      return false;
    } else {
      return true;
    }
  }
}
