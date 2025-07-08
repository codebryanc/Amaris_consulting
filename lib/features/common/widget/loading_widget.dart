import 'package:flutter/material.dart';

class LoadingWidget {
  Widget getLoading() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: CircularProgressIndicator(),
    );
  }
}
