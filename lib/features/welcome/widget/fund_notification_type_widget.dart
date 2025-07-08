import 'package:flutter/material.dart';

import 'package:amaris_consulting/core/models/wallet/fund_notification_method_type.dart';
import 'package:amaris_consulting/core/models/wallet/fund_entity.dart';
import 'package:amaris_consulting/features/welcome/bloc/welcome_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundNotificationTypeWidget {
  void showDialogNotificationMethod(BuildContext context, FundEntity fund) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Por favor selecciona un método de comunicación",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.sms_outlined),
                  title: const Text('SMS'),
                  onTap: () {
                    
                    // Update fund notification type
                    context.read<WelcomeBloc>().add(DoChangeFundNotificationType(fund, FundNotificationMethodType.sms));

                    // Close modal
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.mark_email_unread_outlined),
                  title: const Text('Email'),
                  onTap: () {

                    // Update fund notification type
                    context.read<WelcomeBloc>().add(DoChangeFundNotificationType(fund, FundNotificationMethodType.email));

                    // Close modal
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
}