import 'package:business_layer/business_layer.dart';
import 'package:flutter/material.dart';
import 'package:hotels/router/fluro_router.dart';

class HomeViewList extends StatelessWidget {
  const HomeViewList({Key? key, required this.previews}) : super(key: key);
  final List<HotelPreview> previews;

  @override
  Widget build(BuildContext context) {
    bool _isBigScreen = MediaQuery.of(context).size.width > 500;

    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: previews.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 280,
            color: Colors.grey[300],
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),),
              elevation: 4,
              margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0, bottom: 8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/images/loading2.gif"),
                        image: AssetImage('assets/images/${previews[index].poster}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              previews[index].name,
                              style: TextStyle(
                                fontSize: (_isBigScreen ? 16 : 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _isBigScreen ? 100 : 80,
                            child: TextButton(
                              child: const Text(
                                'Подробнее',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                              onPressed: () => {
                                AppRouter.router.navigateTo(
                                  context,
                                  Routes.hotelDetails,
                                  routeSettings: RouteSettings(arguments: previews[index]),
                                ),
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                textStyle: TextStyle(
                                  fontSize: (_isBigScreen ? 12 : 9),
                                ),
                                backgroundColor: Colors.blue,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                ),
                                //
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  }
}
