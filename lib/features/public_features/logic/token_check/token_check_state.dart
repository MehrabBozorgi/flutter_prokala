part of 'token_check_cubit.dart';

@immutable
abstract class TokenCheckState {}

class TokenCheckInitial extends TokenCheckState {}

class TokenCheckIsLog extends TokenCheckState {}

class TokenCheckIsNotLog extends TokenCheckState {}
