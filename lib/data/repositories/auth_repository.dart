import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/api_constants.dart';
import '../models/login_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(apiClient: ref.read(apiClientProvider));
});

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<void> login({
    required String email,
    required String password,
    required Function(LoginResponse) onSuccess,
    required Function(String) onFailure,
  }) async {
    try {
      final response = await apiClient.post(
        ApiConstants.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final data = LoginResponse.fromJson(response.data);
        onSuccess(data);
      } else {
        onFailure('Unexpected error occurred');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 400) {
        final detail = e.response?.data['detail'] ?? 'Invalid email or password.';
        onFailure(detail);
      } else {
        onFailure('Connection error. Please try again.');
      }
    } catch (e) {
      onFailure(e.toString());
    }
  }
}
