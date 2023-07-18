import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWrapper extends StatefulWidget {
  const TextFieldWrapper({
    super.key,
    this.labelText,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.onChanged,
    this.controller,
    this.validator,
    this.focusNode,
    this.onSaved,
  });

  final TextEditingController? controller;
  final String? labelText;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  @override
  State<TextFieldWrapper> createState() => _TextFieldWrapperState();
}

class _TextFieldWrapperState extends State<TextFieldWrapper> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      style: Theme.of(context).textTheme.bodyMedium,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffix: widget.obscureText
            ? InkWell(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, top: 4.h, bottom: 4.h),
                  child: Text(
                    _obscureText ? 'show' : 'hide',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            : widget.suffix,
        isDense: false,
        errorMaxLines: 5,
        contentPadding: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 10.w),
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.obscureText ? _obscureText = true : _obscureText = false;
  }
}
