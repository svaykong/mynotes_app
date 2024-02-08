import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    Key? key,
    required this.emailCtr,
  }) : super(key: key);
  final TextEditingController emailCtr;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your email";
          } else if (!value.contains("@")) {
            return "Please enter valid email";
          }
          return null;
        },
        focusNode: _emailFocusNode,
        controller: widget.emailCtr,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Enter your email",
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        enableSuggestions: false,
        onTapOutside: (e) {
          if (_emailFocusNode.hasFocus) {
            _emailFocusNode.unfocus();
          }
        },
      ),
    );
  }
}
