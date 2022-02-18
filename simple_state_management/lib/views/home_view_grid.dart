import 'package:business_layer/business_layer.dart';
import 'package:flutter/material.dart';
import 'package:hotels/router/fluro_router.dart';

class HomeViewGrid extends StatelessWidget {
  const HomeViewGrid({Key? key, required this.previews}) : super(key: key);
  final List<HotelPreview> previews;

  @override
  Widget build(BuildContext context) {
    bool _isBigScreen = MediaQuery.of(context).size.width > 500;

    return GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1, crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2,),
        itemCount: previews.length,
        itemBuilder: (BuildContext ctx, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
            elevation: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 10,
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
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        previews[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: (_isBigScreen ? 16 : 9),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: const Text('Подробнее'),
                      onPressed: () => {
                        AppRouter.router.navigateTo(context, Routes.hotelDetails,
                            routeSettings: RouteSettings(arguments: previews[index]),),
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        ),
                        textStyle: TextStyle(
                          fontSize: (_isBigScreen ? 12 : 9),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },);
  }
}
