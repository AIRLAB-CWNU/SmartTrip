import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smarttrip/core/theme/app_theme.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  static const LatLng _pariCenter = LatLng(48.8584, 2.2945); // 에펠탑 좌표

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('hotel'),
      position: LatLng(48.8561, 2.2930),
      infoWindow: InfoWindow(title: '풀먼 파리 타워 에펠', snippet: '숙소'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    const Marker(
      markerId: MarkerId('eiffel'),
      position: LatLng(48.8584, 2.2945),
      infoWindow: InfoWindow(title: '에펠탑', snippet: '관광지'),
    ),
    const Marker(
      markerId: MarkerId('louvre'),
      position: LatLng(48.8606, 2.3376),
      infoWindow: InfoWindow(title: '루브르 박물관', snippet: '관광지'),
    ),
  };

  final Set<Polyline> _polylines = {
    const Polyline(
      polylineId: PolylineId('route1'),
      points: [
        LatLng(48.8561, 2.2930),
        LatLng(48.8584, 2.2945),
        LatLng(48.8606, 2.3376),
      ],
      color: AppTheme.coral,
      width: 5,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('여행 지도'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              _mapController.animateCamera(
                CameraUpdate.newLatLngZoom(_pariCenter, 14),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _pariCenter,
              zoom: 13,
            ),
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
          ),
          _buildRouteInfoCard(),
        ],
      ),
    );
  }

  Widget _buildRouteInfoCard() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.directions_walk, color: AppTheme.deepBlue),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('최적 경로 안내', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('숙소 -> 에펠탑 -> 루브르', style: TextStyle(fontSize: 12, color: AppTheme.grey)),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('최적화'),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('예상 이동 시간: 45분', style: TextStyle(fontSize: 13)),
                  Text('총 거리: 4.2km', style: TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
