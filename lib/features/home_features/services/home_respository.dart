import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/home_features/model/home_model.dart';
import 'package:flutter_prokala/features/home_features/services/home_api.dart';

class HomeRepository {
  final HomeApiServices _apiServices = HomeApiServices();

  Future<dynamic> callIndexApi() async {
    Response response = await _apiServices.callHomeApi();

    final HomeModel homeModel = HomeModel.fromJson(response.data);

    return homeModel;
  }
}
