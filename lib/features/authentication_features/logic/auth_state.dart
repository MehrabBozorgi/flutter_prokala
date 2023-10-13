part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCompletedState extends AuthState {
  final String token;

  AuthCompletedState(this.token);
}

class AuthErrorState extends AuthState {

  final ErrorMessageClass errorMessage;

  AuthErrorState(this.errorMessage);

}
