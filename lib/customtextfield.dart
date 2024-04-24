import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController customTextFieldController;
  final String? hintText;
  final Icon? prefixIcon;
  final IconData? icon;
  final Icon? suffixIcon;
  final bool obscuredPassword;
  final bool isPassword;

  const CustomTextField({
    Key? key,
    required this.customTextFieldController,
    this.hintText,
    this.prefixIcon,
    this.icon,
    this.suffixIcon,
    this.obscuredPassword = false,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late ValueNotifier<bool> _isHiddenNotifier;

  @override
  void initState() {
    super.initState();
    _isHiddenNotifier = ValueNotifier<bool>(widget.obscuredPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.customTextFieldController,
        obscureText: _isHiddenNotifier.value,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.red,
            ),
          ),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(_isHiddenNotifier.value ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isHiddenNotifier.value = !_isHiddenNotifier.value;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isHiddenNotifier.dispose();
    super.dispose();
  }
}
