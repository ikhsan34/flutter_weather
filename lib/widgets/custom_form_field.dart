import 'package:flutter/material.dart';

enum FormFieldType {
  text,
  email,
  password,
}

class CustomFormField extends StatelessWidget {
  final FormFieldType type;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool? isTextArea;
  final bool? showClearButton;
  final bool? isShowPassword;
  final Function()? onPressed;
  final Widget? suffixIcon;
  const CustomFormField({
    super.key,
    this.type = FormFieldType.text,
    this.hintText,
    this.validator,
    this.isTextArea,
    this.showClearButton,
    this.isShowPassword,
    this.onPressed,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: !(isShowPassword ?? true),
      maxLines: isTextArea ?? false ? 3 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: suffixIcon ??
            (type == FormFieldType.password
                ? IconButton(
                    onPressed: () {
                      // ignore: avoid_print
                      print('currently not implemented (clear button)');
                    },
                    icon: Icon(
                      isShowPassword ?? false ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.grey[500],
                    ),
                  )
                : showClearButton ?? false
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[500],
                        ),
                      )
                    : null),
      ),
    );
  }
}
