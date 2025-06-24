abstract class TextManager{
  /// Validation messages - signup
  static const String emailRequired = "email_required";
  static const String emailInvalid = "email_invalid";
  static const String phoneRequired = "phone_required";
  static const String phoneInvalid = "phone_invalid";
  static const String passwordRequired = "password_required";
  static const String passwordTooShort = "password_too_short";
  static const String firstNameRequired = "first_name_required";
  static const String lastNameRequired = "last_name_required";

  /// UI Texts - signup
  static const String createAccount = "create_account";
  static const String registrationSuccess = "registration_success";
  static const String nameHint = "name_hint";
  static const String firstNameHint = "first_name_hint";
  static const String lastNameHint = "last_name_hint";
  static const String emailHint = "email_hint";
  static const String phoneHint = "phone_hint";
  static const String passwordHint = "password_hint";
  static const String nationalIdHint = "national_id_hint";
  static const String registerButton = "register_button";
  static const String registrationFailed = "registration_failed";
  static const String alreadyHaveAccount = "already_have_account";
  static const String loginText = "login_text";

  /// UI Texts - login
  static const String loginNow = "login_now";
  static const String loginIntroMessage = "login_intro_message";
  static const String noAccountQuestion = "no_account_question";
  static const String signUpText = "sign_up_text";

  static const String fieldIsRequired = "fieldIsRequired";

  /// UI Texts - upload id
  static const String upload = "upload";
  static const String uploadYourId = "upload_your_id";
  static const String instructionPlaceId = "instruction_place_id";
  static const String instructionPositionId = "instruction_position_id";
  static const String instructionClearDetails = "instruction_clear_details";
  static const String uploadPhoto = "upload_photo";
  static const String imageUploadedSuccessfully = "image_uploaded_successfully";
  static const String pleaseTakePhotoFirst = "please_take_photo_first";
  static const String personalInformation = "personalInformation";
  static const String edit = "edit";

  static var nationalIdInvalid = "national_id_invalid";
  static var editProfileText = "edit_profile_text";
  static var rentCarText = "rentCarText";
  static var searchBarHint = "searchBarHint";
  static var home = "home";
  static var profile = "profile";
  static var notification = "notification";
  static var more = "more";
  static var topBrands = "topBrands";
  static var all = "all";
  static var toyotaCar = "toyotaCar" ;
  static var bmwCar= "BMWCar";
  static var fordCar= "fordCar";
  static var hondaCar= "hondaCar";
  static var teslaCar= "teslaCar";
  static var volkswagenCar= "volkswagenCar";
  static var audiCar= "audiCar";
  static var kiaCar= "kiaCar";
  static var mazdaCar= " mazdaCar";
  static var mercedesBenzCar= "mercedesBenzCar";
  static var subaruCar= "subaruCar";
  static var lexusCar= "lexusCar";
  static var nissanCar= "nissanCar";
  static var hyundaiCar= "hyundaiCar";
  static var chevroletCar= "chevroletCar";
  static var porscheCar= "porscheCar";
  static var buickCar= "buickCar";
  static var jeepCar= "jeepCar";
  static var renaultCar= "renaultCar";
  static var volvoCar= "volvoCar";
  static var location = "location";
  static var capacity = "capacity";
  static var brand = "brand";
  static var price = "price";
  static var model = "model";
  static var carType = "carType";
  static var availability = "availability";
  static var filter = "filter";
  static var applyButton = "Show offers";
  static var carCategory = "carCategory";
  static var driverOption = "driverOption";
  static var withDriver = "withDriver";
  static var withoutDriver = "withoutDriver";
  static var availableCarTypes = "availableCarTypes";
  static var allCars = "allCars";
  static var available = "available";
  static var unAvailable = "unAvailable";
  static var seats = "seats";
  static var fuelType = "fuelType";
  static var transmissionTypes = "transmissionTypes";
  static var clear = "clear";
  static var showOffers = "showOffers";
  static var bookingHistory = "booking_history";
  static var renterNotification = "renter_notification";

  ///
  /// UI Texts - Add Car
  static const String add_car_title = "add_car_title";
  static const String edit_car_title = "edit_car_title";
  static const String view_cars_title = "view_cars_title";
  static const String add_car_button = "add_car_button";
  static const String car_added_success = "car_added_success";
  static const String car_updated_success = "car_updated_success";
  static const String car_deleted_success = "car_deleted_success";
  static const String car_added_error = "car_added_error";
  static const String delete_car_title = "delete_car_title";
  static const String delete_car_confirmation = "delete_car_confirmation";
  static const String no_cars_message = "no_cars_message";
  static const String cancel = "cancel";
  static const String delete = "delete";

  /// Car Form Labels
  static const String brand_label = "brand_label";
  static const String model_label = "model_label";
  static const String car_type_label = "car_type_label";
  static const String car_category_label = "car_category_label";
  static const String plate_number_label = "plate_number_label";
  static const String year_label = "year_label";
  static const String color_label = "color_label";
  static const String seating_capacity_label = "seating_capacity_label";
  static const String transmission_type_label = "transmission_type_label";
  static const String fuel_type_label = "fuel_type_label";
  static const String odometer_label = "odometer_label";

  /// Car Form Hints
  static const String brand_hint = "brand_hint";
  static const String model_hint = "model_hint";
  static const String car_type_hint = "car_type_hint";
  static const String car_category_hint = "car_category_hint";
  static const String plate_number_hint = "plate_number_hint";
  static const String year_hint = "year_hint";
  static const String color_hint = "color_hint";
  static const String seating_capacity_hint = "seating_capacity_hint";
  static const String transmission_type_hint = "transmission_type_hint";
  static const String fuel_type_hint = "fuel_type_hint";
  static const String odometer_hint = "odometer_hint";

  /// Car Form Validation Messages
  static const String brand_required = "brand_required";
  static const String model_required = "model_required";
  static const String car_type_required = "car_type_required";
  static const String car_category_required = "car_category_required";
  static const String plate_number_required = "plate_number_required";
  static const String plate_number_invalid = "plate_number_invalid";
  static const String year_required = "year_required";
  static const String year_invalid = "year_invalid";
  static const String year_range_invalid = "year_range_invalid";
  static const String color_required = "color_required";
  static const String seating_capacity_required = "seating_capacity_required";
  static const String seating_capacity_invalid = "seating_capacity_invalid";
  static const String seating_capacity_range = "seating_capacity_range";
  static const String transmission_type_required = "transmission_type_required";
  static const String fuel_type_required = "fuel_type_required";
  static const String odometer_required = "odometer_required";
  static const String odometer_invalid = "odometer_invalid";

  static const String owner_navigation = "owner_navigation";
  static const String owner_home = "owner_home";
  static const String owner_profile = "owner_profile";
  static const String owner_notification = "owner_notification";
}
