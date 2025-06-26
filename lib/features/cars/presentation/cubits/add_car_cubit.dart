import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cark/features/home/presentation/model/car_model.dart';
import 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  // In-memory storage for cars (replace with actual database in production)
  final List<CarModel> _cars = [
    // Sample test data
    CarModel(
      id: 1,
      model: 'Model S',
      brand: 'Tesla',
      carType: 'Sedan',
      carCategory: 'Luxury',
      plateNumber: 'ABC123',
      year: 2020,
      color: 'Red',
      seatingCapacity: 5,
      transmissionType: 'Automatic',
      fuelType: 'Electric',
      currentOdometerReading: 15000,
      availability: true,
      currentStatus: 'Available',
      approvalStatus: true,
      rentalOptions: RentalOptions(
        availableWithoutDriver: true,
        availableWithDriver: false,
        dailyRentalPrice: 500.0,

      ), ownerId: '1',
    ),

    CarModel(
      id: 2,
      model: 'Civic',
      brand: 'Honda',
      carType: 'Sedan',
      carCategory: 'Standard',
      plateNumber: 'XYZ789',
      year: 2019,
      color: 'Blue',
      seatingCapacity: 5,
      transmissionType: 'Manual',
      fuelType: 'Gasoline',
      currentOdometerReading: 30000,
      availability: true,
      currentStatus: 'Available',
      approvalStatus: true,
      rentalOptions: RentalOptions(
        availableWithoutDriver: true,
        availableWithDriver: true,
        dailyRentalPrice: 300.0,
      ), ownerId: '2',
    ),
  ];

  // Constructor with optional dependency injection
  AddCarCubit() : super(AddCarInitial());

  // Get all cars
  List<CarModel> getCars() => _cars;

  /// Adds a new car
  Future<void> addCar(CarModel car) async {
    emit(AddCarLoading());

    try {
      // Simulate an API call or database operation
      await Future.delayed(const Duration(seconds: 1));

      // Add car to list
      _cars.add(car);

      // Uncomment and use repository when implemented
      // await carRepository.addCar(car);

      emit(AddCarSuccess(car: car));
    } catch (e) {
      emit(AddCarError(message: _handleError(e)));
    }
  }

  /// Updates an existing car
  Future<void> updateCar(CarModel updatedCar) async {
    emit(AddCarLoading());

    try {
      // Simulate an API call or database operation
      await Future.delayed(const Duration(seconds: 1));

      // Find and update car
      final index =
          _cars.indexWhere((car) => car.plateNumber == updatedCar.plateNumber);
      if (index != -1) {
        _cars[index] = updatedCar;
        emit(AddCarSuccess(car: updatedCar));
      } else {
        emit(const AddCarError(message: 'Car not found'));
      }
    } catch (e) {
      emit(AddCarError(message: _handleError(e)));
    }
  }

  /// Deletes a car
  Future<void> deleteCar(CarModel car) async {
    emit(AddCarLoading());

    try {
      // Simulate an API call or database operation
      await Future.delayed(const Duration(seconds: 1));

      // Remove car from list
      final success = _cars.remove(car);
      if (success) {
        emit(AddCarSuccess(car: car));
      } else {
        emit(AddCarError(message: 'Car not found'));
      }
    } catch (e) {
      emit(AddCarError(message: _handleError(e)));
    }
  }

  /// Resets the form state to initial
  void reset() {
    emit(AddCarInitial());
  }

  /// Handles and formats error messages
  String _handleError(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Exception) {
      return error.toString();
    } else {
      return 'An unknown error occurred';
    }
  }
}
