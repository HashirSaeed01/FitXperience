import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirmation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Are you sure?"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform the action
                // ...
                Navigator.of(context).pop(true); // Signal confirmation
              },
              child: Text("Confirm"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Signal cancellation
              },
              child: Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}
