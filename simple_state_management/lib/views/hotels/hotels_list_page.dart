import 'package:flutter/material.dart';
import 'package:business_layer/business_layer.dart';
import 'package:provider/provider.dart';
import 'hotels_view_grid.dart';
import 'hotels_view_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              setState(() {
                _isListView = true;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
              setState(() {
                _isListView = false;
              });
            },
          ),
        ],
        // Icon(Icons.list),
        // Icon(Icons.grid_3x3),
        // ],
      ),
      body: SafeArea(
        child: Consumer<HotelsNotifier>(
          builder: (context, state, child) {
            return FutureBuilder<List<HotelPreview>>(
              future: state.previewHotelData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                        );
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    return snapshot.hasError
                        ? const Center(child: Text("Ошибка"))
                        : RefreshIndicator(
                            onRefresh: () {
                              state.loadHotelsPreviewData(notify: true);

                              return state.previewHotelData;
                            },
                            child: _isListView
                                ? HomeViewList(previews: snapshot.data, state: state,)
                                : HomeViewGrid(previews: snapshot.data, state: state,),
                          );
                  default:
                    return const SingleChildScrollView(
                      child: Text('Default'),
                    );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
