import 'package:flutter/material.dart';
import 'package:tic_tac_toe/features/core/widgets/dialog_title.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      titlePadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(10),
      title: DialogTitle(
        title: "Credits",
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(child: Text("Lukas Leitner")),
        ),
      ],
    );
  }
}
