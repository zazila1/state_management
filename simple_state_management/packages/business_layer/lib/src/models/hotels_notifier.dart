import 'package:flutter/material.dart';

import 'hotel.dart';
import 'hotel_preview.dart';

abstract class HotelsNotifier with ChangeNotifier  {
  late Future<List<HotelPreview>> previewHotelDataFuture;
  late Future<Hotel> hotelDataFuture;
  List<HotelPreview> get previewHotelData;
  Hotel? get hotelData;

  //late LoadingState previewLoadingState;
  LoadingState get detailedLoadingState;
  String? get error;

  void loadHotelsPreviewData({bool notify});
  void loadHotelData(String uuid, {bool notify});
  void setLike(String uuid, bool isLiked);
  void setFavorite(String uuid, bool isFavorite);
  void clearDetailedData();
}

enum LoadingState {
  none,
  loading,
  error,
  done,
}

