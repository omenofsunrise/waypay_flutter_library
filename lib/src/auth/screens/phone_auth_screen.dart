import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({
    super.key,
    required this.repository,
    required this.userType,
    this.logoAsset,
    this.logoSize = 110,
    this.title = 'Авторизация сотрудника',
    this.onAuthConfirmed,
    this.confirmationScreenBuilder,
  });

  final CallAuthRepository repository;
  final String userType;
  final String? logoAsset;
  final double logoSize;
  final String title;

  final Future<void> Function(
    CallAuthConfirmResponse response,
    String formattedPhone,
  )?
  onAuthConfirmed;

  final WidgetBuilder? confirmationScreenBuilder;

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _phoneFocus = FocusNode();
  final _phoneFormatter = MaskTextInputFormatter(
    mask: ' (###) ###-##-##',
    filter: {"#": RegExp(r'\d')},
  );

  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    _phoneFocus.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _phoneFocus.removeListener(_onFocusChanged);
    _phoneFocus.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _startAuth(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final formattedPhone = '+7${_phoneFormatter.getUnmaskedText()}';
    await context.read<CallAuthCubit>().startAuth(
      phone: formattedPhone,
      userType: widget.userType,
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CallAuthCubit(repository: widget.repository),
      child: BlocConsumer<CallAuthCubit, CallAuthState>(
        listener: (context, state) async {
          if (state is CallAuthCodeSent) {
            if (!_isDialogShowing && mounted) {
              _isDialogShowing = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => CallConfirmationDialog(
                    callPhone: state.initResponse.callPhone,
                    checkId: state.initResponse.checkId,
                    phone: state.phone,
                  ),
                ).then((_) => _isDialogShowing = false);
              });
            }
          }

          if (state is CallAuthSuccess) {
            if (_isDialogShowing && Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
              _isDialogShowing = false;
            }

            if (widget.onAuthConfirmed != null) {
              await widget.onAuthConfirmed!(state.response, state.phone);
              return;
            }

            if (!mounted) return;
            final builder =
                widget.confirmationScreenBuilder ??
                (_) => ConfirmationScreen(
                  phone: state.phone,
                  onContinue: () => Navigator.of(context).pop(),
                );
            Navigator.of(
              context,
            ).pushReplacement(MaterialPageRoute(builder: builder));
          }

          if (state is CallAuthError) {
            if (_isDialogShowing && Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
              _isDialogShowing = false;
            }
            _showError(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is CallAuthLoading;
          return Scaffold(
            backgroundColor: Color(AppColors.background),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    if (widget.logoAsset != null)
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 65),
                          child: SizedBox(
                            height: widget.logoSize,
                            width: widget.logoSize,
                            child: Image.asset(
                              widget.logoAsset!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    Column(
                      children: [
                        const Spacer(),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                               
                                widget.title,
                                style: AppStyle.manrope(size: 22, weight: FontWeight.w500)
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                                autofocus: true,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [_phoneFormatter],
                                decoration: InputDecoration(
                                  labelText: 'Номер телефона',
                                  labelStyle: AppStyle.regular14.copyWith(
                                    color: const Color(AppColors.black),
                                  ),
                                  prefixText: '+7',
                                  prefixStyle: AppStyle.inter(
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: const Color(AppColors.black),
                                  ),
                                  hintText: ' (___) ___-__-__',
                                  hintStyle:
                                      AppStyle.inter(
                                        size: 16,
                                        weight: FontWeight.w400,
                                      ).copyWith(
                                        color: const Color(
                                          AppColors.black,
                                        ).withOpacity(0.35),
                                      ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Color(AppColors.primary),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Color(AppColors.primary),
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                validator: (_) {
                                  final digits = _phoneFormatter
                                      .getUnmaskedText();
                                  if (digits.isEmpty) {
                                    return 'Введите номер телефона';
                                  }
                                  if (digits.length != 10) {
                                    return 'Номер должен состоять из 10 цифр';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),
                              isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : DefaultButton(
                                      text: 'Подтвердить',
                                      isPrimary: true,
                                      onPressed: () => _startAuth(context),
                                    ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
