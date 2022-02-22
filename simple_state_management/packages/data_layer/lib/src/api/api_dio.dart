import 'dart:math';

import 'package:data_layer/src/api/api.dart';
import 'package:data_layer/src/models/hotel_response.dart';
import 'package:data_layer/src/models/hotels_preview_response.dart';
import 'package:dio/dio.dart';


// I don't have APi implementation for likes and favorites, so i do some fake functional for it
class ApiDio implements Api {
  final Dio _httpClient;
  final String? _baseUrl;
  late Map<String, FakeLikesAndFavoritesHotelData> _fakeHotelData;

  ApiDio(this._httpClient, [this._baseUrl = ""]);

  @override
  Future<List<HotelPreviewResponse>> getHotelsPreviewResponse() async {
    final List<HotelPreviewResponse> _data;
    final Response responseData;

    try {
      responseData = await _httpClient.get('${_baseUrl}ac888dc5-d193-4700-b12c-abb43e289301');
    } on DioError catch (e) {
      String error = e.response?.data["message"] ?? e.error.toString();

      return Future.error(error);
    }

    try {
      _data = List<HotelPreviewResponse>.from(
        responseData.data.map((preview) => HotelPreviewResponse.fromJson(preview)),
      );

      _generateStartFakeData(_data);
      
      return _data;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<HotelResponse> getHotelResponse(String uuid) async {
    HotelResponse _data;
    final Response responseData;
    try {
      responseData = await _httpClient.get('$_baseUrl$uuid');
    } on DioError catch (e) {
      String error = e.response?.data["message"] ?? e.error.toString();

      return Future.error(error);
    }

    try {
      _data = HotelResponse.fromJson(responseData.data);

      return _data;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> setHotelFavoriteStatus(String uuid, bool isFavorite) async {
    //FAKE;
    return true;
  }

  @override
  Future<bool> setHotelLikeStatus(String uuid, bool isLiked) async {
    //FAKE;
    return true;
  }

  _generateStartFakeData(List<HotelPreviewResponse> list)
  {
    Random rnd = Random();
    list.map((item) => _fakeHotelData[item.uuid] = FakeLikesAndFavoritesHotelData(rnd.nextBool(), rnd.nextBool()));
  }

}

class FakeLikesAndFavoritesHotelData {
  FakeLikesAndFavoritesHotelData(this. isLiked, this.isFavorite);
  late bool isLiked;
  late bool isFavorite;
}