import 'package:flutter/material.dart';

class CaptureWidget extends StatelessWidget {
  const CaptureWidget({
    super.key,
    required this.mainText,
  });

  final TextEditingController mainText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: TextField(
              controller: mainText,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                contentPadding:  EdgeInsets.all(30),
                filled: true,
                fillColor: Color.fromARGB(255, 153, 191, 255),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none),
              )),
        ),
      ),
    );
  }
}
