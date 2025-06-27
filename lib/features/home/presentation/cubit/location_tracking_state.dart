import 'package:equatable/equatable.dart';
import '../model/location_request_model.dart';

abstract class LocationTrackingState extends Equatable {
  const LocationTrackingState();

  @override
  List<Object?> get props => [];
}

class LocationTrackingInitial extends LocationTrackingState {}

class LocationTrackingLoading extends LocationTrackingState {}

class LocationTrackingSuccess extends LocationTrackingState {
  final LocationRequestModel locationRequest;

  const LocationTrackingSuccess(this.locationRequest);

  @override
  List<Object?> get props => [locationRequest];
}

class LocationTrackingError extends LocationTrackingState {
  final String message;

  const LocationTrackingError(this.message);

  @override
  List<Object?> get props => [message];
}

class LocationHistoryLoaded extends LocationTrackingState {
  final List<LocationRequestModel> locationHistory;

  const LocationHistoryLoaded(this.locationHistory);

  @override
  List<Object?> get props => [locationHistory];
} 