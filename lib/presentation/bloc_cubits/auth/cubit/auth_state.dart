part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;
  final String? error;

  const AuthState({this.error, this.status = AuthStatus.initial, this.user});

  AuthState copyWith({AuthStatus? status, UserModel? user, String? error}) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}
