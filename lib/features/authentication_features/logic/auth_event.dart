part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CallAuthEvent extends AuthEvent{
  final String phoneNumber;

  CallAuthEvent(this.phoneNumber);
}

class CallLogOutEvent extends AuthEvent{}