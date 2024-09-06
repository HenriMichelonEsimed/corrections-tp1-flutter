class Car {
  late String make;
  late String model;
  late bool isruning;
  late double price;
  late DateTime builddate;

  Car(this.make, this.model, this.isruning, this.price, this.builddate);

  Car.fromMap(Map<String, dynamic> json) {
    make = json['make'];
    model = json['model'];
    isruning = bool.parse(json['isruning']);
    price = double.parse(json['price']);
    builddate = DateTime.parse(json['builddate']);
  }

  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'model': model,
      'isruning': isruning.toString(),
      'price': price.toString(),
      'builddate': builddate.toIso8601String(),
    };
  }
}