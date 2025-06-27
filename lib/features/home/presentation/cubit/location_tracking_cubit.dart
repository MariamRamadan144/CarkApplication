import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../model/location_request_model.dart';
import 'location_tracking_state.dart';

class LocationTrackingCubit extends Cubit<LocationTrackingState> {
  LocationTrackingCubit() : super(LocationTrackingInitial());

  // In-memory storage for location requests (simulate database)
  final List<LocationRequestModel> _locationHistory = [];

  // Simulate API call to get car location
  Future<void> requestCarLocation(int carId) async {
    try {
      emit(LocationTrackingLoading());

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Generate random coordinates (simulate GPS data)
      final random = Random();
      final latitude = 30.0444 + (random.nextDouble() - 0.5) * 0.1; // Around Cairo
      final longitude = 31.2357 + (random.nextDouble() - 0.5) * 0.1;

      // Create location request
      final locationRequest = LocationRequestModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        carId: carId,
        timestamp: DateTime.now(),
        latitude: latitude,
        longitude: longitude,
        status: 'completed',
      );

      // Store in local "database"
      _locationHistory.add(locationRequest);

      emit(LocationTrackingSuccess(locationRequest));
    } catch (e) {
      emit(LocationTrackingError('Failed to get car location: ${e.toString()}'));
    }
  }

  // Get location history for a specific car
  Future<void> getLocationHistory(int carId) async {
    try {
      emit(LocationTrackingLoading());

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Filter history by car ID
      final carHistory = _locationHistory
          .where((request) => request.carId == carId)
          .toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp)); // Most recent first

      emit(LocationHistoryLoaded(carHistory));
    } catch (e) {
      emit(LocationTrackingError('Failed to load location history: ${e.toString()}'));
    }
  }

  // Get all location history
  List<LocationRequestModel> getAllLocationHistory() {
    return List.from(_locationHistory)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Clear location history (for testing purposes)
  void clearLocationHistory() {
    _locationHistory.clear();
    emit(LocationTrackingInitial());
  }
} 