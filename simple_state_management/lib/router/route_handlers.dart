import 'package:fluro/fluro.dart';
import 'package:hotels/views/hotels/hotel_detailed_view.dart';
import 'package:hotels/views/hotels/hotels_list_page.dart';
import 'package:business_layer/business_layer.dart';

Handler homeHandler = Handler(handlerFunc: (context, params) {
  return const HomeView();
});

Handler hotelDetailsHandler = Handler(handlerFunc: (context, params) {
  final args = context!.settings!.arguments as HotelPreview;

  return HotelDetailsView(hotelPreview: args);
});
