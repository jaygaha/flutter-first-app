import 'package:flutter/material.dart';
import 'package:to_do_app/utils/app_button.dart';

class DialogBox extends StatefulWidget { //made it stateful to be able to change the date
  final TextEditingController textController;
  final Function(DateTime?) onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.textController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime? selectedDate;

  // Date picker
  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Task input
            TextField(
              controller: widget.textController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Create a new task..."),
            ),

            // Due date picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? "No due date"
                        : "Due: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  ),
                ),
                AppButton(
                  text: "Pick Date",
                  onPressed: pickDate,
                ),
              ],
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  text: "Save",
                  onPressed: () => widget.onSave(selectedDate),
                ),
                const SizedBox(width: 8),
                AppButton(
                  text: "Cancel",
                  onPressed: widget.onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
