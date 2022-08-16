import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key, required this.markerPos}) : super(key: key);
  final List markerPos;
  @override
  State<Map> createState() => _MapState();
}

// 구글 맵

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  late CameraPosition _kGooglePlex;
  GoogleMapController? mapController;

  @override
  void initState() {
    // TODO: implement initState
    _kGooglePlex = CameraPosition(
      target: LatLng(
          widget.markerPos[0][0], widget.markerPos[0][1] as double), // 현재좌표
      zoom: 10,
    );

    for (int i = 0; i < widget.markerPos.length; i++) {
      markers.add(Marker(
          markerId: MarkerId("$i"),
          draggable: false,
          onTap: () => print("Marker!"),
          position: LatLng(widget.markerPos[i][0], widget.markerPos[i][1])));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        markers: Set.from(markers),
        initialCameraPosition: _kGooglePlex,
        onCameraMove: (CameraPosition position) {
          print("카메라이동");
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          mapController = controller;
        },
      ),
    );
  }
}
