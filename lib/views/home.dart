import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rubber/rubber.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Google Maps Controller
  Completer<GoogleMapController> _controller = new Completer();
  static const LatLng _center = const LatLng(-6.6612506, 106.4010367);

  // Rubber Controller
  RubberAnimationController _rubberAnimationController;
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onCreateGoogleMaps,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 8.0
            ),
          )
        ],
      ),
    );
  }

  void _onCreateGoogleMaps(GoogleMapController controller) {
    _controller.complete(controller);
  }
}
