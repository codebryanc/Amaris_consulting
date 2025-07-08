import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final String message;
  final bool isError;
  final VoidCallback? onClose;

  const NotificationWidget({
    super.key,
    required this.message,
    this.isError = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isError ? Colors.red.shade50 : Colors.blue.shade50,
        border: Border.all(
          color: isError ? Colors.red : const Color.fromARGB(255, 7, 119, 212),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.info_outline,
            color: isError ? Colors.red : const Color.fromARGB(255, 7, 119, 212),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isError ? Colors.red.shade800 : Colors.blue.shade800,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onClose != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                color: isError ? Colors.red : const Color.fromARGB(255, 7, 119, 212),
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget insufficientFunds({VoidCallback? onClose}) {
    return NotificationWidget(
      message: "No tienes saldo suficiente para hacer la suscripción",
      isError: true,
      onClose: onClose,
    );
  }

  static Widget success(String message) {
    return NotificationWidget(
      message: message,
      isError: false,
    );
  }

  static Widget error(String message) {
    return NotificationWidget(
      message: message,
      isError: true,
    );
  }
}