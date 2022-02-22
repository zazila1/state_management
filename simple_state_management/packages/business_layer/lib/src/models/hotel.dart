import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel.freezed.dart';
part 'hotel.g.dart';

@freezed
class Hotel with _$Hotel {
  const factory Hotel({
    required String uuid,
    required String name,
    required String poster,
    required Address address,
    required double price,
    required double rating,
    required Services services,
    required List<String> photos,
    required bool isLiked,
    required bool isFavorite,
  }) = _Hotel;

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);

  static Future<Hotel>? parseHotel(dynamic responseData) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      return Hotel.fromJson(responseData);
    } catch (e) {
      return Future.error(e);
    }
  }
}

@freezed
class Address with _$Address {
  const factory Address({
    required String country,
    required String street,
    required String city,
    required int zipCode,
    required Coords coords,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
class Coords with _$Coords {
  const factory Coords({
    required double lat,
    required double lan,
  }) = _Coords;

  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);
}

@freezed
class Services with _$Services {
  const factory Services({
    required List<String> free,
    required List<String> paid,
  }) = _Services;

  factory Services.fromJson(Map<String, dynamic> json) => _$ServicesFromJson(json);
}
