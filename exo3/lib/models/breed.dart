
import 'package:exo3/models/image.dart';

class Breed {
  late String id;
  late String name;
  late String description;
  Image? image;

  Breed(this.id, this.name, this.description, this.image);

  Breed.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['image'] != null) image = Image.fromMap(json['image']);
  }

  Map<String, dynamic> toMap() => {
    'id' : id,
    'name' : name,
    'description' : description
  };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) => id == (other as Breed).id;

  @override
  int get hashCode => id.hashCode;


}