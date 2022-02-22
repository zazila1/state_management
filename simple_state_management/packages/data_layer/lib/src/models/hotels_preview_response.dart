import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotels_preview_response.freezed.dart';
part 'hotels_preview_response.g.dart';

@freezed
class HotelPreviewResponse with _$HotelPreviewResponse {
  factory HotelPreviewResponse({
    required String uuid,
    @Default('') String name,
    @Default('') String poster,
    @Default(false) bool isLiked,
    @Default(false) bool isFavorite,
  }) = _HotelPreviewResponse;

  factory HotelPreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$HotelPreviewResponseFromJson(json);
}
