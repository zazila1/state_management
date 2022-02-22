import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_response.freezed.dart';
part 'hotel_response.g.dart';

@freezed
class HotelResponse with _$HotelResponse {
  const factory HotelResponse({
    required String uuid,
    required String name,
    required String poster,
    required AddressResponse address,
    required double price,
    required double rating,
    required ServicesResponse services,
    required List<String> photos,
    @Default(false) bool isLiked,
    @Default(false) bool isFavorite,

  }) = _HotelResponse;

  factory HotelResponse.fromJson(Map<String, dynamic> json) => _$HotelResponseFromJson(json);
}

@freezed
class AddressResponse with _$AddressResponse {
  const factory AddressResponse({
    required String country,
    required String street,
    required String city,
    @JsonKey(name: 'zip_code') required int zipCode,
    required CoordsResponse coords,
  }) = _AddressResponse;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);
}

@freezed
class CoordsResponse with _$CoordsResponse {
  const factory CoordsResponse({
    required double lat,
    required double lan,
  }) = _CoordsResponse;

  factory CoordsResponse.fromJson(Map<String, dynamic> json) => _$CoordsResponseFromJson(json);
}

@freezed
class ServicesResponse with _$ServicesResponse {
  const factory ServicesResponse({
    required List<String> free,
    required List<String> paid,
  }) = _ServicesResponse;

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => _$ServicesResponseFromJson(json);
}
