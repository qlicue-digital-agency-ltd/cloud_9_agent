import 'package:flutter/material.dart';

typedef LabelTextfieldOnChange = Function(String);

class LabelTextfield extends StatelessWidget {
  final String hitText;
  final String labelText;
  final int maxLines;
  final String message;
  final String prefix;
  final String surfix;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final LabelTextfieldOnChange onChange;
  final GlobalKey<FormFieldState> formFieldKey;
  final double extraPadding;

  final FocusNode focusNode;

  final TextEditingController textEditingController;

  Function onEditingComplete;
  TextInputAction textInputAction;

  Function validator;

  LabelTextfield({
    Key key,
    @required this.hitText,
    @required this.labelText,
    @required this.focusNode,
    @required this.textEditingController,
    @required this.maxLines,
    @required this.message,
    @required this.keyboardType,
    this.prefix,
    this.prefixIcon,
    this.surfix,
    this.onChange,
    this.formFieldKey,
    this.extraPadding = 0.0,
    this.textInputAction,
    this.onEditingComplete,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      keyboardType: keyboardType,
      focusNode: focusNode,
      key: formFieldKey,
      controller: textEditingController,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefix: prefix != null ? Text(prefix) : null,
        suffix: surfix != null ? Text(surfix) : null,
        prefixIcon: prefixIcon != null
            ? Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  prefixIcon,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : null,
        hintText: hitText,
        labelText: labelText,
      ),
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      validator: validator ?? (value) {
        if (message != null) {
          if (value.isEmpty) {
            return "\t\t\t\t\t\t\t\t\t\t\t\t\t\t" + message;
          } else
            return null;
        } else
          return null;
      },
    );
  }
}
