import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(authRepository: ref.read(authRepositoryProvider));
});

class LoginState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  LoginState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthRepository authRepository;

  LoginViewModel({required this.authRepository}) : super(LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    await authRepository.login(
      email: email,
      password: password,
      onSuccess: (response) {
        state = state.copyWith(isLoading: false, isSuccess: true);
      },
      onFailure: (errorMessage) {
        state = state.copyWith(isLoading: false, error: errorMessage);
      },
    );
  }
}
