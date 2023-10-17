import 'package:dio/dio.dart';

import '../model/search_model.dart';
import 'search_api_service.dart';

class SearchRepository {
  SearchApiServices apiServices = SearchApiServices();

  Future<SearchModel> callSearchApi(String search) async {
    final Response response = await apiServices.callSearchApi(search);

    SearchModel searchModel = SearchModel.fromJson(response.data);

    return searchModel;
  }
}
