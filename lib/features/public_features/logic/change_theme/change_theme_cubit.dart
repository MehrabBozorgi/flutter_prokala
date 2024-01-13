import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../const/theme/theme.dart';


class ChangeThemeCubit extends Cubit<ThemeData> {
  ChangeThemeCubit() : super(ThemeData.light());

  ThemeData customTheme = CustomTheme.lightTheme;


  changeTheme(){

    if (customTheme == CustomTheme.darkTheme) {
      emit(customTheme = CustomTheme.lightTheme);
    }
    else {
      emit(customTheme = CustomTheme.darkTheme);
    }

  }


}
