import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:sandbox/core/location/location_manager.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';

class Boomscape extends StatefulWidget {
  const Boomscape({super.key});

  @override
  State<Boomscape> createState() => _BoomscapeState();
}

enum BoomscapeSelection {
  current(0),
  future(1);

  const BoomscapeSelection(this.value);

  final int value;

  BoomscapeSelection fromIndex(int index) {
    switch (index) {
      case 0:
        return BoomscapeSelection.current;
      case 1:
        return BoomscapeSelection.future;
      default:
        return BoomscapeSelection.current;
    }
  }
}

class _BoomscapeState extends State<Boomscape> {
  BoomscapeSelection selectedState = BoomscapeSelection.current;
  late MapboxMap _mapController;
  bool hasLoadedUserLocation = false;

  @override
  void initState() {
    MapboxOptions.setAccessToken(
        'pk.eyJ1IjoibWF0dGVvYnV4bWFuIiwiYSI6ImNsdG85ZmE3MTBmYWsycXJxZmJ1ajF1bjkifQ.f7FqOvPUkAIqAlXty7p4VA');

    super.initState();
  }

  void _onMapLoaded(MapboxMap data) async {
    _mapController = data;

    //Get the user's current location
    final userPosition = await LocationManager.determinePosition();

    //Add the annotations to the map
    _mapController.annotations
        .createPolygonAnnotationManager()
        .then((polygonannotationmanager) async {
      polygonannotationmanager.create(PolygonAnnotationOptions());
    });

    //Remove the scale bar
    _mapController.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

    _mapController.setCamera(CameraOptions(
      zoom: 10,
      center: Point(
              coordinates:
                  Position(userPosition.longitude, userPosition.latitude))
          .toJson(),
    ));

    //Center the map on the user's location
    // _mapController.location.updateSettings(LocationComponentSettings(
    //     enabled: true,
    //     locationPuck: LocationPuck(
    //         locationPuck3D: LocationPuck3D(
    //       modelUri:
    //           "https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Duck/glTF-Embedded/Duck.gltf",
    //     ))));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapWidget(
            onMapCreated: _onMapLoaded,
            styleUri: 'mapbox://styles/matteobuxman/cltoaowlj01o201pj57wh8xgt',
          ),
          FractionallySizedBox(
            widthFactor: 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: SegmentedButtonSlide(
                      entries: const [
                        SegmentedButtonSlideEntry(label: "Current"),
                        SegmentedButtonSlideEntry(label: "Future")
                      ],
                      selectedEntry: selectedState.value,
                      onChange: (selected) => setState(() =>
                          selectedState = selectedState.fromIndex(selected)),
                      colors: SegmentedButtonSlideColors(
                          barColor: Colors.grey.shade200.withOpacity(0.8),
                          backgroundSelectedColor: Colors.white,
                          foregroundSelectedColor: Colors.black,
                          foregroundUnselectedColor: Colors.black,
                          hoverColor: Colors.grey.withOpacity(0.8)),
                      height: 30,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
