import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  int currentIndex = 0;

  changeCurrentIndex(int index) {
    emit(currentIndex = index);
  }
}
