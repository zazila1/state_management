import 'package:data_layer/data_layer.dart';
import 'package:flutter/material.dart';

import '../models/hotel.dart';
import '../models/hotel_preview.dart';
import '../models/hotels_notifier.dart';

class HotelsState with ChangeNotifier implements HotelsNotifier {
  HotelsState(this._hotelsRepository) {
    loadHotelsPreviewData();
  }
  final HotelsRepository _hotelsRepository;

  @override
  late Future<List<HotelPreview>> previewHotelData;
  @override
  late Future<Hotel> hotelData;

  @override
  void loadHotelsPreviewData({bool notify = true}) async {
    previewHotelData = _getHotelsPreviewDataFromApi();
    previewHotelData.then(
      (value) => {
        if (notify) notifyListeners(),
      },
    );

    //return previewHotelData;
  }

  @override
  void loadHotelData(String uuid, {bool notify = true}) async {
    hotelData = _getHotelDataFromApi(uuid);

    hotelData.then(
      (value) => {
        if (notify) notifyListeners(),
      },
    );
  }

  @override
  void setFavorite(String uuid, bool isLiked) {
    _hotelsRepository.setHotelFavoriteStatus(
      uuid,
      isLiked,
    );
    notifyListeners();
  }

  @override
  void setLike(String uuid, bool isLiked) {
    _hotelsRepository.setHotelLikeStatus(
      uuid,
      isLiked,
    );
    notifyListeners();
  }

  Future<List<HotelPreview>> _getHotelsPreviewDataFromApi() async {
    var data = await _hotelsRepository.getHotelsPreviewData();

    return Future.value(_generateHotelsPreviewWithResponseData(data));
  }

  Future<Hotel> _getHotelDataFromApi(String uuid) async {
    var data = await _hotelsRepository.getHotelData(uuid);

    return Future.value(_generateHotelWithResponseData(data));
  }

  List<HotelPreview> _generateHotelsPreviewWithResponseData(List<HotelPreviewResponse> data) {
    // some logic on a sample of data

    List<HotelPreview> _hotelsPreview = [];

    for (var item in data) {
      //print(item);
      _hotelsPreview.add(HotelPreview(
        uuid: item.uuid,
        name: item.name,
        poster: item.poster,
        isFavorite: item.isFavorite,
        isLiked: item.isLiked,
      ));
    }

    return _hotelsPreview;
  }

  Hotel _generateHotelWithResponseData(HotelResponse data) {
    // some logic on a sample of data

    Services _services = Services(free: data.services.free, paid: data.services.paid);
    Coords _coords = Coords(lat: data.address.coords.lat, lan: data.address.coords.lan);
    Address _address = Address(
      country: data.address.country,
      street: data.address.street,
      city: data.address.city,
      zipCode: data.address.zipCode,
      coords: _coords,
    );
    Hotel _hotel = Hotel(
      uuid: data.uuid,
      name: data.name,
      poster: data.poster,
      address: _address,
      price: data.price,
      rating: data.rating,
      services: _services,
      photos: data.photos,
      isLiked: data.isLiked,
      isFavorite: data.isFavorite,
    );

    return _hotel;
  }
}
