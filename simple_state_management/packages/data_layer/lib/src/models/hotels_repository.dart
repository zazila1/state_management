import 'hotel_response.dart';
import 'hotels_preview_response.dart';

abstract class HotelsRepository {
  Future<List<HotelPreviewResponse>> getHotelsPreviewData();
  Future<HotelResponse> getHotelData(String uuid);
  Future<bool> setHotelLikeStatus(String uuid, bool isLiked);
  Future<bool> setHotelFavoriteStatus(String uuid, bool isFavorite);
}