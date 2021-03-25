import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

typedef MobileTextfieldOnChange = Function(String);
typedef MobileCountryCodeOnChange = Function(Country);

class MobileTextfield extends StatelessWidget {
  final String hitText;
  final String labelText;
  final int maxLines;
  final String message;
  final TextInputType keyboardType;
  final MobileTextfieldOnChange onChange;
  final MobileCountryCodeOnChange onCodeChange;
  final GlobalKey<FormFieldState> formFieldKey;
  final double extraPadding;

  final FocusNode focusNode;
  final Country selectedCountry;

  final TextEditingController textEditingController;
  final _UsNumberTextInputFormatter _phoneNumberFormatter =
      _UsNumberTextInputFormatter();

  MobileTextfield(
      {Key key,
      @required this.hitText,
      @required this.labelText,
      @required this.focusNode,
      @required this.textEditingController,
      @required this.maxLines,
      @required this.message,
      @required this.onCodeChange,
      @required this.selectedCountry,
      @required this.keyboardType,
      this.onChange,
      this.formFieldKey,
      this.extraPadding = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        CountryPicker(
          dense: false,
          showFlag: true,
          showDialingCode: true,
          showName: false,
          onChanged: onCodeChange,
          selectedCountry: selectedCountry,
        ),
        Expanded(
          child: TextFormField(
            onChanged: onChange,
            keyboardType: keyboardType,
            focusNode: focusNode,
            key: formFieldKey,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(13),
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.singleLineFormatter,
              _phoneNumberFormatter,
            ],
            controller: textEditingController,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hitText,
              labelText: labelText,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (message != null) {
                if (value.isEmpty) {
                  return message;
                } else
                  return null;
              } else
                return null;
            },
          ),
        ),
      ],
    );
  }
}

/// Format incoming numeric text to fit the format of (###) ###-#### ##...
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
