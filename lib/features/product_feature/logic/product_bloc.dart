import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/product_feature/model/product_model.dart';
import 'package:flutter_prokala/features/public_features/error/error_message_class.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../services/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<CallProductEvent>(_callDetailProduct);
  }

  List<String> newGallery = [];

  FutureOr<void> _callDetailProduct(CallProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingSate());

    try {
      final ProductModel productModel = await productRepository.callDetailProduct(event.id);

      if (productModel.gallery != null) {
        newGallery.add(productModel.product!.image!);

        for (int i = 0; i < productModel.gallery!.length; i++) {
          newGallery.add(productModel.gallery![i].path!);
        }
      }
      emit(ProductCompletedSate(productModel));
    } on DioException catch (e) {
      emit(ProductErrorSate(ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e))));
    }
  }
}
