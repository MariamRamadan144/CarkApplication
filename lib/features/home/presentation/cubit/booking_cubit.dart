import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_cark/features/home/presentation/model/booking_model.dart';
import 'package:test_cark/features/home/presentation/model/car_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  Future<void> fetchBookings() async {
    try {
      emit(BookingLoading());
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // This is where you would make your actual API call.
      // For now, we'll return mock data.
      final List<BookingModel> bookings = [
        BookingModel(
          car: CarModel.mock(),
          startDate: DateTime(2024, 5, 20),
          endDate: DateTime(2024, 5, 23),
          totalPrice: 6400.00,
          status: 'Completed',
        ),
        BookingModel(
          car: CarModel.mock().copyWith(brand: 'BMW', model: 'X5'),
          startDate: DateTime(2024, 6, 15),
          endDate: DateTime(2024, 6, 18),
          totalPrice: 450.00,
          status: 'Active',
        ),
      ];

      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError("Failed to fetch bookings."));
    }
  }
} 