import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.checklist_outlined),
              title: Text('0 tasks available'),
              subtitle: Text('Create new using plus button'),
            ),
          ],
        ),
      ),
    );
  }
}
