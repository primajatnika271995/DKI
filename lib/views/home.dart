import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rubber/rubber.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // Google Maps Controller
  Completer<GoogleMapController> _controller = new Completer();
  static const LatLng _center = const LatLng(-6.2295712, 106.7594782);

  // Rubber Controller
  RubberAnimationController _rubberAnimationController;
  ScrollController _scrollController = new ScrollController();

  Widget _getLowerLayer() {
    return GoogleMap(
      onMapCreated: _onCreateGoogleMaps,
      initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("Item $index"));
          },
          itemCount: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RubberBottomSheet(
        scrollController: _scrollController,
        lowerLayer: _getLowerLayer(),
        upperLayer: _getUpperLayer(),
        animationController: _rubberAnimationController,
      )
    );
  }

  @override
  void initState() {
    _rubberAnimationController = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.5),
        duration: Duration(milliseconds: 200)
    );
    super.initState();
  }

  void _onCreateGoogleMaps(GoogleMapController controller) {
    _controller.complete(controller);
  }
}
