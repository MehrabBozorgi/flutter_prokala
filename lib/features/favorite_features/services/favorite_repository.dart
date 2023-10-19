import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/favorite_features/services/favorite_api_services.dart';

import '../model/favorite_model.dart';

class FavoriteRepository {
  final FavoriteApiServices _apiServices = FavoriteApiServices();

  Future<bool> addToFavorite(String id) async {
    final Response response = await _apiServices.addToFavoriteApi(id);

    return response.data['boolean'];
  }

  Future<FavoriteModel> callFavoriteList() async {
    final Response response = await _apiServices.callFavoriteList();

    final FavoriteModel favoriteModel = FavoriteModel.fromJson(response.data);
    return favoriteModel;
  }

  Future<void> removeItemFavorite(int id) async {
    await _apiServices.removeItemFavorite(id);
  }
}
