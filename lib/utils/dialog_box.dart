import 'package:flutter/material.dart';
import 'package:to_do_app/utils/app_button.dart';

class DialogBox extends StatelessWidget {
  final textController;
  VoidCallback onSave;
  VoidCallback onConcel;

  DialogBox(
      {super.key,
      required this.textController,
      required this.onSave,
      required this.onConcel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.black12,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Create a new task..."),
            ),

            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(text: "Save", onPressed: onSave),
                const SizedBox(
                  width: 8,
                ),
                AppButton(text: "Cancel", onPressed: onConcel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
