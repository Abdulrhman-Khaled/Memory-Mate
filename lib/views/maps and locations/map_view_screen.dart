import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constatnts.dart';
import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';
import '../../providers/second_user_location.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late Dio dio;

  late DioClient dioClient;

  late PatientUserApi userApi;

  late PatientUserRepository patientUserRepository;

  bool isLoading = false;

  late Timer timer;

  final CameraPosition _initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0));

  late GoogleMapController mapController;

  // LatLng secondUserLatLng = const LatLng(29.962897, 32.541546);

  late Position _currentPosition;

  Set<Marker> markers = {};

  List<dynamic> secondUserLocationInfo = [];

  late PolylinePoints polylinePoints;

  Map<PolylineId, Polyline> polylines = {};

  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final Set<Marker> _markers = {};

  final Set<Polyline> _polylines = {};

  String userName = 'Loading...';
  String userBio = 'Loading...';

  Future<void> postMyLocation() async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    await patientUserRepository.postUserLocationRequest(
        _currentPosition.latitude, _currentPosition.longitude, userToken!);
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        if (kDebugMode) {
          print('CURRENT POS: $_currentPosition');
        }
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  Marker buildSecondUserMarker(SecondUserLocation location) {
    // ignore: unnecessary_null_comparison
    if (location == null) {
      return const Marker(
        markerId: MarkerId('مقدم الرعاية'),
        position: LatLng(0, 0),
      );
    } else {
      return Marker(
        markerId: const MarkerId('Second User'),
        position: LatLng(location.latitude, location.longitude),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        infoWindow: InfoWindow(title: userName, snippet: userBio),
        onTap: () {
          _getRoute();
        },
      );
    }
  }

  void moveToSecondUser() {
    SecondUserLocationProvider provider =
        Provider.of<SecondUserLocationProvider>(context, listen: false);
    LatLng secondUserLatLng =
        LatLng(provider.location.latitude, provider.location.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(secondUserLatLng));
  }

  void _getRoute() async {
    LatLng userLatLng =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);

    SecondUserLocationProvider provider =
        Provider.of<SecondUserLocationProvider>(context, listen: false);
    LatLng secondUserLatLng =
        LatLng(provider.location.latitude, provider.location.longitude);

    List<LatLng> routeCoords =
        await _getRouteCoords(userLatLng, secondUserLatLng);

    setState(() {
      _polylines.clear();
      _polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        visible: true,
        points: routeCoords,
        width: 5,
        color: AppColors.mintGreen,
      ));
    });
  }

  Future<List<LatLng>> _getRouteCoords(
      LatLng userLatLng, LatLng secondUserLatLng) async {
    List<LatLng> routeCoords = [];

    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${userLatLng.latitude},${userLatLng.longitude}&destination=${secondUserLatLng.latitude},${secondUserLatLng.longitude}&key=AIzaSyCG0tgMelOBDyILs5zDCLlTQw49jrlBCFg';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        List<LatLng> points = PolylinePoints()
            .decodePolyline(data['routes'][0]['overview_polyline']['points'])
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        routeCoords.addAll(points);
      }
    }

    return routeCoords;
  }

  Future<void> getUserLocation() async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    List<dynamic> secondUserLocation =
        await patientUserRepository.getSecondUserLocationRequest(userToken!);
    log(secondUserLocation.toString());
    // ignore: use_build_context_synchronously
    await updateSecondUserLocation(
        context, secondUserLocation[0]['lng'], secondUserLocation[0]['lat']);

    String name = secondUserLocation[0]['full_name'].toString();
    String bio = secondUserLocation[0]['bio'].toString();

    setState(() {
      secondUserLocationInfo = secondUserLocation;
      userName = name;
      userBio = bio;
      isLoading = false;
    });

    await postMyLocation();
  }

  Future<void> updateSecondUserLocation(
      BuildContext context, double latitude, double longitude) async {
    SecondUserLocationProvider provider =
        Provider.of<SecondUserLocationProvider>(context, listen: false);
    provider.setLocation(latitude, longitude);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getUserLocation();

    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      log("================fetch done===============");
      getUserLocation();
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData(
            color: AppColors.mintGreen,
          ),
          centerTitle: true,
          title: const Text(
            'الأماكن وتحديدالمواقع',
            style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.mintGreen,
                backgroundColor: AppColors.white,
              ))
            : Consumer<SecondUserLocationProvider>(
                builder: (context, provider, child) {
                return Stack(
                  children: <Widget>[
                    // Map View
                    GoogleMap(
                      // ignore: prefer_collection_literals
                      markers: Set<Marker>.of(
                          [buildSecondUserMarker(provider.location)]),
                      polylines: _polylines,
                      initialCameraPosition: _initialLocation,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                        _markers.add(buildSecondUserMarker(provider.location));
                        setState(() {});
                      },
                      onTap: (LatLng latLng) {
                        setState(() {
                          _polylines.clear();
                        });
                      },
                    ),
                    // Show Zoom Buttons
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipOval(
                              child: Material(
                                color: const Color.fromARGB(70, 35, 210, 134),
                                child: InkWell(
                                  splashColor: AppColors.mintGreen,
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: AppColors.lightBlack,
                                    ),
                                  ),
                                  onTap: () {
                                    mapController.animateCamera(
                                      CameraUpdate.zoomIn(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ClipOval(
                              child: Material(
                                color: const Color.fromARGB(70, 210, 35, 35),
                                child: InkWell(
                                  splashColor: AppColors.mintGreen,
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.remove,
                                      size: 30,
                                      color: AppColors.lightBlack,
                                    ),
                                  ),
                                  onTap: () {
                                    mapController.animateCamera(
                                      CameraUpdate.zoomOut(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: AppColors.mintGreen,
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                      'assets/images/icons/secondlocation.png',
                                    ),
                                  ),
                                  onTap: () {
                                    moveToSecondUser();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Show current location button
                    SafeArea(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: ClipOval(
                            child: Material(
                              color: AppColors.mintGreen, // button color
                              child: InkWell(
                                splashColor: AppColors.white, // inkwell color
                                child: const SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.my_location,
                                    color: AppColors.white,
                                  ),
                                ),
                                onTap: () {
                                  mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                          _currentPosition.latitude,
                                          _currentPosition.longitude,
                                        ),
                                        zoom: 19,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
      ),
    );
  }
}
