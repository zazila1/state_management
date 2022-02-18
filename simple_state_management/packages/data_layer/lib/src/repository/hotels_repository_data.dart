import 'package:data_layer/src/api/api.dart';
import 'package:data_layer/src/models/hotels_repository.dart';
import 'package:data_layer/src/models/hotel_response.dart';
import 'package:data_layer/src/models/hotels_preview_response.dart';


class HotelsRepositoryData implements HotelsRepository {
  HotelsRepositoryData(this._api);

  final Api _api;

  @override
  Future<HotelResponse> getHotelData(String uuid) {
    return _api.getHotelResponse(uuid);
  }

  @override
  Future<List<HotelPreviewResponse>> getHotelsPreviewData() {
    return _api.getHotelsPreviewResponse();
  }

}
