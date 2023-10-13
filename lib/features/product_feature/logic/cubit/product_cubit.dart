import 'package:bloc/bloc.dart';


class ProductCubit extends Cubit<int> {
  ProductCubit() : super(0);


  int currentIndex=0;

  changeIndex(index){
    emit(currentIndex=index);
  }

}
