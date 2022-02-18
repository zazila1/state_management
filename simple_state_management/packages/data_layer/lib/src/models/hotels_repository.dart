import 'hotel_response.dart';
import 'hotels_preview_response.dart';

abstract class HotelsRepository {
  Future<List<HotelPreviewResponse>> getHotelsPreviewData();
  Future<HotelResponse> getHotelData(String uuid);
}