import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:business_layer/business_layer.dart';
import 'package:hotels/views/hotels/description_text.dart';
import 'package:provider/provider.dart';

class HotelDetailsView extends StatefulWidget {
  const HotelDetailsView({Key? key, required this.hotelPreview}) : super(key: key);

  final HotelPreview hotelPreview;

  @override
  _HotelDetailsViewState createState() => _HotelDetailsViewState();
}

class _HotelDetailsViewState extends State<HotelDetailsView> {
  @override
  void initState() {
    Provider.of<HotelsNotifier>(context, listen: false)
        .loadHotelData(widget.hotelPreview.uuid, notify: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotelPreview.name),
      ),
      body: SafeArea(
        child: Consumer<HotelsNotifier>(builder: (context, state, child) {
          return FutureBuilder<Hotel>(
            future: state.hotelData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center();
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());

                case ConnectionState.done:
                  return snapshot.hasError
                      ? Center(child: Text(snapshot.error.toString()))
                      : SingleChildScrollView(
                          child: Column(children: [
                            CarouselSlider(
                              options: CarouselOptions(autoPlay: true, enlargeCenterPage: false),
                              items: snapshot.data.photos
                                  .map<Widget>((item) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Center(
                                          child: FadeInImage(
                                            placeholder:
                                                const AssetImage("assets/images/loading2.gif"),
                                            image: AssetImage('assets/images/$item'),
                                            width: 1000.0,
                                            height: 650,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                              child: Column(children: [
                                DescriptionText(
                                  label: "Страна",
                                  text: snapshot.data.address.country,
                                ),
                                DescriptionText(label: "Город", text: snapshot.data.address.city),
                                DescriptionText(label: "Улица", text: snapshot.data.address.street),
                                DescriptionText(
                                  label: "Рейтинг",
                                  text: snapshot.data.rating.toString(),
                                ),
                                DescriptionText(
                                  label: "Индекс",
                                  text: snapshot.data.address.zipCode.toString(),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                                  child: const Text(
                                    "Сервисы",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Платные",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ...snapshot.data.services.paid
                                                .map((e) => Text(e.toString()))
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Платные",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ...snapshot.data.services.free
                                                .map((e) => Text(e.toString()))
                                                .toList(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ]),
                            ),
                          ]),
                        );
                default:
                  return const SingleChildScrollView(
                    child: Text('Default'),
                  );
              }
            },
          );
        }),
      ),
    );
  }
}
