  import 'package:flutter/material.dart';

SnackBar buildErrorSnackBarWidget({required String errorMessage}) {
    return SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

