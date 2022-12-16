// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

const EdgeInsets SCORLL_PADDING_DEFAULT = EdgeInsets.all(20.0);

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool? obscureText;
  final FocusNode? focusNode;
  final void Function(String?)? onChanged;
  final TextAlign textAlign;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final EdgeInsets? contentPadding;
  final EdgeInsets? scrollPadding;

  const Input({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.focusNode,
    this.obscureText,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines = 10,
    this.minLines = 1,
    this.contentPadding,
    this.scrollPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: obscureText == true ? 1 : maxLines,
      minLines: minLines,
      cursorColor: CustomColors.primaryGreen,
      cursorHeight: 14,
      style: Theme.of(context).textTheme.button!.copyWith(
            height: 1.14,
            color: CustomColors.primaryGreen,
          ),
      decoration: InputDecoration(
        labelText: label ?? "",
        hintText: hint ?? "",
        floatingLabelBehavior: hint != null
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        labelStyle: Theme.of(context).textTheme.button!.copyWith(
              color: CustomColors.grayScale[500],
            ),
        floatingLabelStyle: Theme.of(context).textTheme.button!.copyWith(
              color: CustomColors.grayScale[800],
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              vertical: 8,
            ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD6D6D6),
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.black,
            width: 1,
          ),
        ),
        counterText: '',
      ),
      obscureText: obscureText ?? false,
      textAlign: textAlign,
      scrollPadding: scrollPadding ?? SCORLL_PADDING_DEFAULT,
    );
  }
}

class TransparentTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChange;
  final FocusNode? focusNode;
  final EdgeInsets? scrollPadding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const TransparentTextField({
    super.key,
    required this.controller,
    this.onChange,
    this.focusNode,
    this.scrollPadding,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: this.focusNode,
      controller: this.controller,
      onChanged: this.onChange,
      cursorColor: CustomColors.primaryGreen,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.button!.copyWith(
            height: 1.14,
            color: CustomColors.primaryGreen,
          ),
      textAlign: TextAlign.right,
      scrollPadding: scrollPadding ?? SCORLL_PADDING_DEFAULT,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
