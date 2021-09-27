import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:learn_flutter/views/datos.dart';

class HomeView extends StatefulWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  GoogleMapController? _controller;

  final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

  final Set<Marker> _markers = {};

  CameraPosition? currentPosition;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('App test'),
        actions: [
          IconButton(
            onPressed: () => _getCurrentLocation(), 
            icon: const Icon(Icons.location_history)
          ),
        ]
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxHeight: 200
                    ),
                    child: GoogleMap(
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      buildingsEnabled: true,
                      onCameraMove: (newPosition){
                        currentPosition = newPosition;
                      },
                      markers: _markers,
                      mapType: MapType.satellite,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        print('NewController: $controller');
                        _controller = controller;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addMarker,
        label: const Text('Agregar pin'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // For moving the camera to current location
        _controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 3.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  // A => 1

  void addMarker() async {
    final LatLng? coords = currentPosition?.target;
    if(coords == null) return; 

    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(coords.toString()),
        position: coords,
        infoWindow: const InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DatosView())),
      ));
    });
  }
}
