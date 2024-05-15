class Car {
  late int id;
  late String model;
  late String make;
  late String year;
  late double price;
  late String description;
  late String status;
  late String image;
  late String engine;
  late String transmission;
  late String fuelType;

  Car(
    this.id,
    this.model,
    this.make,
    this.year,
    this.price,
    this.description,
    this.status,
    this.image,
    this.engine,
    this.transmission,
    this.fuelType,
  );

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    make = json['make'];
    year = json['year'];
    image = json['image'];
    status = json['status'];
    engine = json['engine'];
    transmission = json['transmission'];
    fuelType = json['fuelType'];
    price = json['price'] + .0;
    description = json['description'];
  }
}
