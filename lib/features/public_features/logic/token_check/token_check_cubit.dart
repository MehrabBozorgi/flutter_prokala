import 'package:bloc/bloc.dart';
import 'package:flutter_prokala/features/public_features/functions/secure_storage.dart';
import 'package:meta/meta.dart';

part 'token_check_state.dart';

class TokenCheckCubit extends Cubit<TokenCheckState> {
  TokenCheckCubit() : super(TokenCheckInitial());

  tokenCheck() async {
    final status = await SecureStorageClass().getUserToken();

    if (status != null) {
      emit(TokenCheckIsLog());

    } else {
      emit(TokenCheckIsNotLog());

    }
  }
}
