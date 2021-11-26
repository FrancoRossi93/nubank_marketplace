import 'package:flutter/material.dart';

class SnackBarError {
  SnackBarError._();
  static buildErrorSnackBar(BuildContext context, {String errorMessage}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent.shade700,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width / 1.1,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                textAlign: TextAlign.center,
              )
            ],
          )));
  }
}

class SnackBarSuccess {
  SnackBarSuccess._();
  static buildSuccessSnackBar(BuildContext context, {String successMessage}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent.shade700,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width / 1.1,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                successMessage,
                textAlign: TextAlign.center,
              )
            ],
          )));
  }
}
