import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.passCtr,
  }) : super(key: key);
  final TextEditingController passCtr;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;
  late FocusNode _passFocusNode;

  @override
  void initState() {
    super.initState();
    _passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passFocusNode.dispose();
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
            return "Please enter your password";
          } else if (value.length < 4) {
            return "Your password is short";
          }
          return null;
        },
        focusNode: _passFocusNode,
        obscureText: _obscure,
        controller: widget.passCtr,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.key),
          hintText: "Enter your password",
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
            icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          ),
        ),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        autocorrect: false,
        enableSuggestions: false,
        onTapOutside: (e) {
          if (_passFocusNode.hasFocus) {
            _passFocusNode.unfocus();
          }
        },
      ),
    );
  }
}
