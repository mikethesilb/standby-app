import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  BitmapDescriptor pinLocationIcon;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    // Grab markers
    final googleOffices = await locations.getGoogleOffices();
    // Map style
    controller.setMapStyle(Utils.mapStyles);
    //Load the icons
    List<BitmapDescriptor> icons = await loadallpins();

    setState(() {
      // Clear current markers
      _markers.clear();
      // Add all points to map
      for (final office in googleOffices.offices) {
        int icontype = 1; // Here logic to decide icon
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          icon: icons[icontype], // update the icon
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  Future<List<BitmapDescriptor>> loadallpins() async {
    List<BitmapDescriptor> icons = [null, null, null, null, null, null];
    for (int i in [1,2,3,4,5]){
      icons[i] = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(106,106)),
        'assets/Syr'+i.toString()+'.png');
    }
    return icons;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StandBy'),
          backgroundColor: Colors.blueGrey[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              trafficEnabled: false,
              compassEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: const LatLng(32.0853, 34.7818),
                zoom: 9,
              ),
              markers: _markers.values.toSet(),

              // TODO, change info box make it nicer (https://medium.com/flutter-community/add-a-custom-info-window-to-your-google-map-pins-in-flutter-2e96fdca211a)
              // onTap: (LatLng location) {
              //   setState(() {
              //     pinPillPosition = -100;
              //   });
              // },
            ),
          ]
        )
      ),
    );
  }
}



// Map style
class Utils {
  static String mapStyles = '''[
    {
        "featureType": "all",
        "elementType": "all",
        "stylers": [
            {
                "hue": "#e7ecf0"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#636c81"
            }
        ]
    },
    {
        "featureType": "administrative.neighborhood",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#636c81"
            }
        ]
    },
    {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#ff0000"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#f1f4f6"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#496271"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "saturation": -70
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#c6d3dc"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#898e9b"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "saturation": -60
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#d3eaf8"
            }
        ]
    }
]''';
}