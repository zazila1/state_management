import 'package:data_layer/src/models/hotel_response.dart';
import 'package:data_layer/src/models/hotels_preview_response.dart';

abstract class Api<T> {
  Future<List<HotelPreviewResponse>> getHotelsPreviewResponse();
  Future<HotelResponse> getHotelResponse(String uuid);
}
