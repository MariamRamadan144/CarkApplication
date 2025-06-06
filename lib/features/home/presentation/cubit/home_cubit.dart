// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class HomeCubit extends Cubit<bool> {
//   HomeCubit() : super(true); // true means "with driver"
//
//   void toggleFilter(bool value) => emit(value);
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/car_category_model.dart';
import '../model/car_type_model.dart';
import 'home_state.dart';

// Cubit for managing car selection
class CarCubit extends Cubit<ChooseCarState> {
  CarCubit() : super(const ChooseCarState());

  // Static lists for car options
  // static const List<String> carCategories = [
  //   'Economy',
  //   'Luxury',
  //   'Sports',
  //   'Off-road',
  //   'Electric',
  // ];
  static const List<String> driverOptions = [
    'With Driver',
    'Without Driver',
  ];
  // static const List<String> carTypes = [
  //   'SUV',
  //   'Sedan',
  //   'Hatchback',
  //   'Truck',
  //   'Van',
  //   'Coupe',
  //   'Convertible',
  //   'Other',
  // ];
  static const List<CarTypeModel> carTypes = [
    CarTypeModel(type: 'SUV', icon: Icons.directions_car_filled),
    CarTypeModel(type: 'Sedan', icon: Icons.directions_car),
    CarTypeModel(type: 'Hatchback', icon: Icons.directions_car),
    CarTypeModel(type: 'Truck', icon: Icons.local_shipping),
    CarTypeModel(type: 'Van', icon: Icons.airport_shuttle),
    CarTypeModel(type: 'Coupe', icon: Icons.time_to_leave),
    CarTypeModel(type: 'Convertible', icon: Icons.car_rental),
    CarTypeModel(type: 'Other', icon: Icons.directions_car_outlined),
  ];

  static const List<CarCategoryModel> carCategories = [
    CarCategoryModel(name: 'Economy', icon: Icons.attach_money),
    CarCategoryModel(name: 'Luxury', icon: Icons.star),
    CarCategoryModel(name: 'Sports', icon: Icons.speed),
    CarCategoryModel(name: 'Off-road', icon: Icons.terrain),
    CarCategoryModel(name: 'Electric', icon: Icons.electric_car),
  ];

  static const List<String> fuelTypes = [
    'Petrol',
    'Diesel',
    'Electric',
    'Hybrid',
  ];
  static const List<String> transmissions = [
    'Manual',
    'Automatic',
  ];


  void setCarType(String type) => emit(state.copyWith(carType: type));
  void setCategory(String cat) => emit(state.copyWith(category: cat));
  void setTransmission(String trans) => emit(state.copyWith(transmission: trans));
  void setFuel(String fuel) => emit(state.copyWith(fuel: fuel));
  void toggleWithDriver(bool value) => emit(state.copyWith(withDriver: value));
  void toggleWithoutDriver(bool value) => emit(state.copyWith(withoutDriver: value));
  void setDailyPrice(double price) => emit(state.copyWith(dailyPrice: price));
  void setMonthlyPrice(double price) => emit(state.copyWith(monthlyPrice: price));
  void setYearlyPrice(double price) => emit(state.copyWith(yearlyPrice: price));
  void setWithDriver(bool value) {
    emit(state.copyWith(withDriver: value));
  }
  void resetFilters() {
    emit(state.copyWith(carType: ''));
  }



}


// Cubit for managing filter options
// class FilterCubit extends Cubit<FilterState> {
//   FilterCubit() : super(FilterState.initial());
//
//   void updateSelectedBrands(List<String> brands) {
//     emit(state.copyWith(selectedBrands: brands));
//   }
//
//   void updateSelectedPriceRange(RangeValues range) {
//     emit(state.copyWith(selectedPriceRange: range));
//   }
//
//   void updateSelectedModels(List<String> models) {
//     emit(state.copyWith(selectedModels: models));
//   }
//
//   void updateSelectedCarTypes(List<String> types) {
//     emit(state.copyWith(selectedCarTypes: types));
//   }
//
//   void updateSelectedAvailability(String status) {
//     emit(state.copyWith(selectedAvailability: status));
//   }
//
//   void updateSelectedCarCategories(List<String> categories){
//     emit(state.copyWith(selectedCarCategories: categories));
//   }
//
//   void updateSelectedDriverOptions (List<String> options) {
//     emit(state.copyWith(selectedDriverOptions: options));
//   }
//
//   void updateSelectedFuelTypes(List<String> fuels) {
//     emit(state.copyWith(selectedFuelTypes: fuels));
//   }
//
//   void updateSelectedTransmissionTypes(List<String> types) {
//     emit(state.copyWith(selectedTransmissionTypes: types));
//   }
//
//   void updateSelectedSeats(List<int> seats) {
//     emit(state.copyWith(selectedSeats: seats));
//   }
//
//   void updateSelectedDriverOption(String option) {
//     emit(state.copyWith(selectedDriverOption: option));
//   }
// }
