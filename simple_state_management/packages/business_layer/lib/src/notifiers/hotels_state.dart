import 'package:data_layer/data_layer.dart';
import 'package:flutter/material.dart';

import '../models/hotel.dart';
import '../models/hotel_preview.dart';
import '../models/hotels_notifier.dart';

class HotelsState with ChangeNotifier implements HotelsNotifier {
  HotelsState(this._hotelsRepository) {
    loadHotelsPreviewData();
  }

  Hotel? _hotelData;
  late List<HotelPreview> _previewHotelData;
  final HotelsRepository _hotelsRepository;
  LoadingState _detailedLoadingState = LoadingState.none;
  String? _error;
  // @override
  // LoadingState previewLoadingState = LoadingState.none;
  @override
  LoadingState get detailedLoadingState => _detailedLoadingState;
  @override
  Hotel? get hotelData => _hotelData;
  @override
  List<HotelPreview> get previewHotelData => _previewHotelData;
  @override
  String? get error => _error;

  @override
  late Future<List<HotelPreview>> previewHotelDataFuture;
  @override
  late Future<Hotel> hotelDataFuture;

  @override
  void loadHotelsPreviewData({bool notify = true}) async {
    previewHotelDataFuture = _getHotelsPreviewDataFromApi();
    previewHotelDataFuture.then(
      (value) => {
        if (notify) notifyListeners(),
      },
    );

    //return previewHotelData;
  }

  @override
  void loadHotelData(String uuid, {bool notify = true}) async {
    _setLoadingState(error: null, loadingState: LoadingState.loading);

    try {
      _hotelData = await _getHotelDataFromApi(uuid);
      _setLoadingState(error: null, loadingState: LoadingState.done);
    } catch (e) {
      _setLoadingState(error: e.toString(), loadingState: LoadingState.error);
      _hotelData = null;
    }

    if (notify) {
      notifyListeners();
    }
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

  @override
  void clearDetailedData() {
    _setLoadingState(error: null, loadingState: LoadingState.none);
    _hotelData = null;
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

  void _setLoadingState({required error, required loadingState}) {
    _error = error;
    _detailedLoadingState = loadingState;
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
