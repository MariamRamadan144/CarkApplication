class CarModel {
  final int id;
  final String model;
  final String brand;
  final String carType;
  final String carCategory;
  final String plateNumber;
  final int year;
  final String color;
  final int seatingCapacity;
  final String transmissionType;
  final String fuelType;
  final int currentOdometerReading;
  final bool availability;
  final String currentStatus;
  final bool approvalStatus;
  final RentalOptions rentalOptions;
  final String imageUrl;

  CarModel({
    required this.id,
    required this.model,
    required this.brand,
    required this.carType,
    required this.carCategory,
    required this.plateNumber,
    required this.year,
    required this.color,
    required this.seatingCapacity,
    required this.transmissionType,
    required this.fuelType,
    required this.currentOdometerReading,
    required this.availability,
    required this.currentStatus,
    required this.approvalStatus,
    required this.rentalOptions,
    this.imageUrl = 'https://cdn-icons-png.flaticon.com/512/743/743007.png', // placeholder

  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      model: json['model'],
      brand: json['brand'],
      carType: json['car_type'],
      carCategory: json['car_category'],
      plateNumber: json['plate_number'],
      year: json['year'],
      color: json['color'],
      seatingCapacity: json['seating_capacity'],
      transmissionType: json['transmission_type'],
      fuelType: json['fuel_type'],
      currentOdometerReading: json['current_odometer_reading'],
      availability: json['availability'],
      currentStatus: json['current_status'],
      approvalStatus: json['approval_status'],
      rentalOptions: RentalOptions.fromJson(json['rental_options']),
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/743/743007.png',

    );
  }
}

class RentalOptions {
  final bool availableWithoutDriver;
  final bool availableWithDriver;
  final double? dailyRentalPrice;
  final double? monthlyRentalPrice;
  final double? yearlyRentalPrice;
  final double? dailyRentalPriceWithDriver;
  final double? monthlyPriceWithDriver;
  final double? yearlyPriceWithDriver;

  RentalOptions({
    required this.availableWithoutDriver,
    required this.availableWithDriver,
    this.dailyRentalPrice,
    this.monthlyRentalPrice,
    this.yearlyRentalPrice,
    this.dailyRentalPriceWithDriver,
    this.monthlyPriceWithDriver,
    this.yearlyPriceWithDriver,
  });

  factory RentalOptions.fromJson(Map<String, dynamic> json) {
    return RentalOptions(
      availableWithoutDriver: json['available_without_driver'],
      availableWithDriver: json['available_with_driver'],
      dailyRentalPrice: json['daily_rental_price']?.toDouble(),
      monthlyRentalPrice: json['monthly_rental_price']?.toDouble(),
      yearlyRentalPrice: json['yearly_rental_price']?.toDouble(),
      dailyRentalPriceWithDriver: json['daily_rental_price_with_driver']?.toDouble(),
      monthlyPriceWithDriver: json['monthly_price_with_driver']?.toDouble(),
      yearlyPriceWithDriver: json['yearly_price_with_driver']?.toDouble(),
    );
  }
}
