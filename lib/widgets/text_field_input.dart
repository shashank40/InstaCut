import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass; /// to check text is pass or not
  final String hintText;
  final TextInputType textInputType; // to check do we neec to show whic type of keyboard
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false, // default app
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration( /// values we take from constructor so that we can have custom things
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType, 
      obscureText: isPass, //// true only when text is pass
    );
  }
}
