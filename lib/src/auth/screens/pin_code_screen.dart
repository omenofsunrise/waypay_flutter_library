import 'package:flutter/material.dart';
import 'package:waypay_styles/waypay_styles.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({
    super.key,
    required this.onValidatePin,
    required this.onCreatePin,
    required this.loadSavedPin,
    this.onSuccess,
    this.logoAsset,
    this.logoSize = 84,
    this.pinLength = 5,
    this.titleExisting = 'Введите пин-код',
    this.titleRepeat = 'Повторите пин-код',
    this.titleCreate = 'Придумайте пин-код',
  });

  final Future<bool> Function(String pin) onValidatePin;
  final Future<void> Function(String pin) onCreatePin;
  final Future<String?> Function() loadSavedPin;
  final Future<void> Function()? onSuccess;
  final String? logoAsset;
  final double logoSize;
  final int pinLength;
  final String titleExisting;
  final String titleRepeat;
  final String titleCreate;

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final List<String> _pin = [];
  String? _firstPin;
  String? _errorMessage;
  bool _isSecondStep = false;
  bool _isExistingUser = false;
  String? _pressedKey;

  @override
  void initState() {
    super.initState();
    _checkExistingPin();
  }

  Future<void> _checkExistingPin() async {
    final savedPin = await widget.loadSavedPin();
    if (savedPin != null && mounted) {
      setState(() {
        _isExistingUser = true;
      });
    }
  }

  void _onKeyboardTap(String value) {
    if (value == 'back') {
      if (_pin.isNotEmpty) {
        setState(() => _pin.removeLast());
      }
    } else {
      if (_pin.length < widget.pinLength) {
        setState(() => _pin.add(value));
        if (_pin.length == widget.pinLength) {
          _onSubmit();
        }
      }
    }
  }

  Future<void> _onSubmit() async {
    final pin = _pin.join();

    if (pin.length < widget.pinLength) {
      setState(() {
        _errorMessage =
            'Пин-код должен содержать минимум ${widget.pinLength} цифр';
      });
      return;
    }

    if (_isExistingUser) {
      final isValid = await widget.onValidatePin(pin);
      if (isValid) {
        await widget.onSuccess?.call();
      } else {
        setState(() {
          _errorMessage = 'Неверный пин-код';
          _pin.clear();
        });
      }
    } else {
      if (!_isSecondStep) {
        setState(() {
          _firstPin = pin;
          _pin.clear();
          _isSecondStep = true;
          _errorMessage = null;
        });
      } else {
        if (_firstPin == pin) {
          try {
            await widget.onCreatePin(pin);
            await widget.onSuccess?.call();
          } catch (e) {
            setState(() {
              _errorMessage = e.toString();
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Пин-коды не совпадают';
            _pin.clear();
            _isSecondStep = false;
            _firstPin = null;
          });
        }
      }
    }
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLength, (index) {
        final filled = index < _pin.length;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? const Color(AppColors.primary) : Colors.grey[400],
          ),
        );
      }),
    );
  }

  Widget _buildKey(String value) {
    final isBack = value == 'back';
    final display = value == 'empty' ? '' : value;
    final isPressed = _pressedKey == value;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTapDown: display.isEmpty
            ? null
            : (_) => setState(() => _pressedKey = value),
        onTapCancel: () {
          if (_pressedKey == value) setState(() => _pressedKey = null);
        },
        onTapUp: display.isEmpty
            ? null
            : (_) {
                setState(() => _pressedKey = null);
                _onKeyboardTap(value);
              },
        child: AnimatedScale(
          scale: isPressed ? 0.94 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Container(
            alignment: Alignment.center,
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: isBack ? const Color(0xFFF3F6F9) : Colors.white,
              border: display.isNotEmpty && !isBack
                  ? Border.all(color: const Color(AppColors.primary))
                  : null,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: isBack
                ? const Icon(
                    Icons.backspace_outlined,
                    color: Color(AppColors.primary),
                    size: 24,
                  )
                : Text(
                    display,
                    style: AppStyle.medium20.copyWith(
                      fontSize: 22,
                      color: const Color(AppColors.primary),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['empty', '0', 'back'],
    ];

    String title;
    if (_isExistingUser) {
      title = widget.titleExisting;
    } else if (_isSecondStep) {
      title = widget.titleRepeat;
    } else {
      title = widget.titleCreate;
    }

    return Scaffold(
      backgroundColor: Color(AppColors.background),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 32),
              if (widget.logoAsset != null)
                SizedBox(
                  height: widget.logoSize,
                  width: widget.logoSize,
                  child: Image.asset(
                    widget.logoAsset!,
                    fit: BoxFit.contain,
                  ),
                ),
              if (widget.logoAsset != null) const SizedBox(height: 20),
              Text(
                title,
                style: AppStyle.medium20.copyWith(
                  fontSize: 22,
                  color: const Color(AppColors.black),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildPinDots(),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: AppStyle.regular14.copyWith(
                    color: const Color(AppColors.red),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const Spacer(),
              Column(
                children: keys.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((key) {
                      if (key == 'empty') {
                        return const SizedBox(width: 72, height: 72);
                      }
                      return _buildKey(key);
                    }).toList(),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
