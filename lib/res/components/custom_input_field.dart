import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final TextEditingController? controller;
  final TextInputType keyboardInputType;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final String password;
  final String confirmPassword;

  const CustomInputField(
      {required this.hintText,
      this.suffixIcon,
      this.onChanged,
      this.isPasswordField = false,
      required this.controller,
      this.keyboardInputType = TextInputType.text,
      this.focusNode,
      this.password = "",
      this.confirmPassword = "",
      super.key});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  void dispose() {
    obscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 249, 136, 31)),
      borderRadius: BorderRadius.circular(10),
    );
    final OutlineInputBorder unFocusBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );
    return ValueListenableBuilder(
      valueListenable: obscureText,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              controller: widget.controller,
              textInputAction: TextInputAction.next,
              obscureText: widget.isPasswordField ? obscureText.value : false,
              keyboardType: widget.keyboardInputType,
              decoration: InputDecoration(
                suffixIcon: !widget.isPasswordField
                    ? widget.suffixIcon
                    : IconButton(
                        onPressed: () {
                          obscureText.value = obscureText.value ? false : true;
                        },
                        icon: Icon(obscureText.value
                            ? Icons.visibility_off
                            : Icons.visibility)),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: unFocusBorder,
                focusedBorder: border,
                disabledBorder: unFocusBorder,
                errorBorder: border,
                focusedErrorBorder: border,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "${widget.hintText} can't be empty!";
                } else if (widget.isPasswordField) {
                  if (widget.password != widget.confirmPassword) {
                    return "password didn't match!";
                  }
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }
}
