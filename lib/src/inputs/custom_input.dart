import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool isDateField;
  final VoidCallback? onTap;
  final InputType inputType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onUserInput;

  const CustomInput({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.isDateField = false,
    this.onTap,
    this.inputType = InputType.text,
    this.onChanged,
    this.onUserInput,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

enum InputType { text, fullname }

class _CustomInputState extends State<CustomInput> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (widget.inputType == InputType.fullname) {
      _formatFullName();
    }
    widget.onChanged?.call(widget.controller.text);
  }

  void _formatFullName() {
    final String text = widget.controller.text;

    String cleanedText = text.replaceAll(RegExp(r'[0-9]'), '');

    if (cleanedText.isNotEmpty) {
      final List<String> words = cleanedText.split(' ');
      final List<String> formattedWords = words.map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).toList();

      cleanedText = formattedWords.join(' ');
    }

    if (cleanedText != text) {
      widget.controller.value = widget.controller.value.copyWith(
        text: cleanedText,
        selection: TextSelection.collapsed(offset: cleanedText.length),
        composing: TextRange.empty,
      );
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = widget.controller.text.isNotEmpty;
    final bool shouldShowLabel = _isFocused || hasText;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Focus(
        onFocusChange: (bool focused) {
          setState(() {
            _isFocused = focused;
          });
        },
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.inputType == InputType.fullname
              ? TextInputType.text
              : widget.keyboardType,
          readOnly: widget.isDateField,
          onTap: widget.onTap,
          focusNode: _focusNode,
          onChanged: (String value) {
            if (_focusNode.hasFocus) {
              widget.onUserInput?.call(value);
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(AppColors.lightGreyBackground),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(AppColors.primary),
                width: 2,
              ),
            ),
            labelText: widget.label,
            labelStyle: AppStyle.manrope(
              size: shouldShowLabel ? 12 : 14,
              weight: FontWeight.w400,
              color: shouldShowLabel ? const Color(AppColors.black) : Colors.grey,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: null,
          ),
          style: AppStyle.manrope(size: 14, weight: FontWeight.w400),
        ),
      ),
    );
  }
}
