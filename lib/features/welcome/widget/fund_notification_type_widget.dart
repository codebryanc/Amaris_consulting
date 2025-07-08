import 'package:flutter/material.dart';

import 'package:amaris_consulting/core/models/wallet/fund_notification_method_type.dart';

class FundNotificationTypeWidget {
  void showDialogNotificationMethod(BuildContext context, Function(FundNotificationMethodType) onMethodSelected) {
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
                    // Call callback with selected type
                    onMethodSelected(FundNotificationMethodType.sms);

                    // Close modal
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.mark_email_unread_outlined),
                  title: const Text('Email'),
                  onTap: () {
                    
                    // Call callback with selected type
                    onMethodSelected(FundNotificationMethodType.email);

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