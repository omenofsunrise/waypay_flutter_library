import 'package:flutter_bloc/flutter_bloc.dart';

import '../call_auth_repository.dart';
import '../models.dart';

abstract class CallAuthState {
  const CallAuthState();
}

class CallAuthInitial extends CallAuthState {
  const CallAuthInitial();
}

class CallAuthLoading extends CallAuthState {
  const CallAuthLoading();
}

class CallAuthCodeSent extends CallAuthState {
  final CallAuthInitResponse initResponse;
  final String phone;

  const CallAuthCodeSent(this.initResponse, this.phone);
}

class CallAuthSuccess extends CallAuthState {
  final CallAuthConfirmResponse response;
  final String phone;

  const CallAuthSuccess(this.response, this.phone);
}

class CallAuthError extends CallAuthState {
  final String message;

  const CallAuthError(this.message);
}

class CallAuthCubit extends Cubit<CallAuthState> {
  CallAuthCubit({
    required CallAuthRepository repository,
  })  : _repository = repository,
        super(const CallAuthInitial());

  final CallAuthRepository _repository;

  Future<void> startAuth({
    required String phone,
    required String userType,
  }) async {
    emit(const CallAuthLoading());
    try {
      final initResponse = await _repository.initiate(
        phone: phone,
        userType: userType,
      );
      emit(CallAuthCodeSent(initResponse, phone));
    } catch (e) {
      emit(CallAuthError(e.toString()));
    }
  }

  Future<void> confirmCall({
    required String checkId,
    required String phone,
    required String userType,
  }) async {
    emit(const CallAuthLoading());
    try {
      final response = await _repository.confirm(
        checkId: checkId,
        phone: phone,
        userType: userType,
      );
      emit(CallAuthSuccess(response, phone));
    } catch (e) {
      emit(CallAuthError(e.toString()));
    }
  }
}
