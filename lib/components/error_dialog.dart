import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorCode;

  const ErrorDialog({super.key, required this.errorCode});

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    // Determine the error message based on the error code
    switch (errorCode) {
      case 'invalid-email':
        errorMessage = 'The email address is invalid or malformed.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided for that user.';
        break;
      case 'invalid-credential':
        errorMessage = 'Wrong password or email provided.';
        break;
      case 'user-disabled':
        errorMessage = 'The user account has been disabled.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Please try again later.';
        break;
      case 'operation-not-allowed':
        errorMessage = 'Email/password authentication is not enabled.';
        break;
      case 'network-request-failed':
        errorMessage = 'A network error occurred. Please check your internet connection.';
        break;
      case 'weak-password':
        errorMessage = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        errorMessage = 'The account already exists for that email.';
        break;
      case 'passwords-not-matching':
        errorMessage = 'The password provided do not match.';
        break;
      default:
        errorMessage = 'An unknown error occurred.';
    }

    // Show the dialog
    return AlertDialog(
      title: Text('Error'),
      content: Text(errorMessage, style: TextStyle(fontSize: 16),),
      actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
      ],
    );
  }
}