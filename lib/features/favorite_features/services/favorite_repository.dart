import 'package:dio/dio.dart';
import 'package:flutter_prokala/features/favorite_features/services/favorite_api_services.dart';

class FavoriteRepository {
  final FavoriteApiServices _apiServices = FavoriteApiServices();

  Future<bool> addToFavorite(String id) async {
    final Response response = await _apiServices.addToFavoriteApi(id);

    return response.data['boolean'];
  }
}
