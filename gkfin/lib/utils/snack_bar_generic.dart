import "package:flutter/material.dart";

void showSnackBar(context, String msgFeedback) {
  // Exibe um snackbar com uma mensagem de feedback
  // Utilizada ao final de uma operação
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msgFeedback),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: "ok",
        onPressed: () async {},
      ),
    ),
  );

}
