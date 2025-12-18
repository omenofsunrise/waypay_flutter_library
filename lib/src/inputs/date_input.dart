import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_style.dart';
import 'custom_calendar.dart';

class DateInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final String prefix;

  const DateInput({
    super.key,
    required this.controller,
    required this.label,
    this.initialDate,
    this.onDateSelected,
    this.prefix = 'Дата:',
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);

    if (widget.initialDate != null) {
      _updateControllerText(widget.initialDate!);
    }
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _showCalendar() {
    _focusNode.unfocus();

    showDialog(
      context: context,
      builder: (context) => CustomCalendar(
        initialDate: _getCurrentDateFromController(),
        onDateSelected: (DateTime date) {
          _updateControllerText(date);
          widget.onDateSelected?.call(date);
        },
        prefix: widget.prefix,
      ),
    );
  }

  DateTime? _getCurrentDateFromController() {
    final String text = widget.controller.text;
    if (text.isEmpty) return widget.initialDate;

    try {
      final List<String> parts = text.split('.');
      if (parts.length == 3) {
        final int day = int.parse(parts[0]);
        final int month = int.parse(parts[1]);
        final int year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (_) {}
    return null;
  }

  void _updateControllerText(DateTime date) {
    final String formattedDate =
        '${_formatTwoDigits(date.day)}.${_formatTwoDigits(date.month)}.${date.year}';
    widget.controller.text = formattedDate;
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }

  void _onTextChanged(String value) {
    String cleanedText = value.replaceAll(RegExp(r'[^0-9.]'), '');

    if (cleanedText.length > 10) {
      cleanedText = cleanedText.substring(0, 10);
    }

    if (cleanedText.length >= 2 &&
        !cleanedText.contains('.') &&
        cleanedText.length > 2) {
      cleanedText =
          '${cleanedText.substring(0, 2)}.${cleanedText.substring(2)}';
    }
    if (cleanedText.length >= 5 && cleanedText.split('.').length == 2) {
      cleanedText =
          '${cleanedText.substring(0, 5)}.${cleanedText.substring(5)}';
    }

    if (cleanedText != value) {
      widget.controller.value = widget.controller.value.copyWith(
        text: cleanedText,
        selection: TextSelection.collapsed(offset: cleanedText.length),
        composing: TextRange.empty,
      );
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = widget.controller.text.isNotEmpty;
    final bool shouldShowLabel = _isFocused || hasText;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.datetime,
        readOnly: false,
        onChanged: _onTextChanged,
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
          hintText: 'дд.мм.гггг',
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.calendar_today,
              size: 20,
              color: Color(AppColors.primary),
            ),
            onPressed: _showCalendar,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        style: AppStyle.manrope(size: 14, weight: FontWeight.w400),
      ),
    );
  }
}
