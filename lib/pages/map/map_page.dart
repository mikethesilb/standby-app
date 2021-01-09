import 'package:bash_new/demo/demo_listings.dart';
import 'package:bash_new/pages/listing/widgets/Listing.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {
  String address = "Shalva 16, Herzliya";
  List<Listing> listings = createTestListings();
  List<Marker> markers = [];

  GoogleMapController mapController;
  LatLng _center;
  bool mapToggle = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void initState() {
    super.initState();
    Geolocator().placemarkFromAddress(address).then((placemarkList) {
      setState(() {
        _center = LatLng(placemarkList[0].position.latitude,
            placemarkList[0].position.longitude);
        BitmapDescriptor.fromAssetImage(
                ImageConfiguration(
                    devicePixelRatio: 0.25, size: new Size(0.0002, 0.0002)),
                'assets/images/testpic.jpg')
            .then((icon) {
          for (Listing listing in listings) {
            markers.add(new Marker(
                markerId: new MarkerId(listing.address),
                consumeTapEvents: false,
                draggable: false,
                position: listing.coordinates,
                onTap: (() => Navigator.of(context)
                    .pushNamed("/ListingPage", arguments: listing))));
          }
        });

        mapToggle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: mapToggle
            ? GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                markers: Set.from(markers),
              )
            : Center(
                child: Text(
                'Loading... Please wait...',
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
      ),
    );
  }
}
