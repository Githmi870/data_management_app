import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Success',
          style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: GoogleFonts.jetBrainsMono(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.pop(context); // Go back to login
            },
            child: Text(
              'Continue to Login',
              style: GoogleFonts.jetBrainsMono(),
            ),
          ),
        ],
      );
    },
  );
}
