class Car {
  int id;
  String model;
  String make;
  int year;
  double price;
  String description;
  String status;
  String image;
  String engine;
  String transmission;
  String fuelType;
  bool isFavorite;

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
      this.isFavorite);

  changeFavorite() {
    isFavorite = !isFavorite;
  }
}
