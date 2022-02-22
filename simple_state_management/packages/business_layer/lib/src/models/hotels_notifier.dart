import 'package:flutter/material.dart';

import 'hotel.dart';
import 'hotel_preview.dart';

abstract class HotelsNotifier with ChangeNotifier  {
  late Future<List<HotelPreview>> previewHotelData;
  late Future<Hotel> hotelData;

  void loadHotelsPreviewData({bool notify});
  void loadHotelData(String uuid, {bool notify});
  void setLike(String uuid, bool isLiked);
  void setFavorite(String uuid, bool isFavorite);
}
