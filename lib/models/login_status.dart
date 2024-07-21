import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_status.freezed.dart';

@freezed
class LoginStatus with _$LoginStatus {
  const factory LoginStatus({
    required String? userId,
    required String? email,
    required String? displayName,
    required String? photoUrl,
  }) = _LoginStatus;

  factory LoginStatus.empty() => const LoginStatus(
        userId: null,
        email: null,
        displayName: null,
        photoUrl: null,
      );
}
