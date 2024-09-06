import 'package:exo3/database.dart';
import 'package:exo3/models/breed.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Breed> _favorites = [];
  final _tableName = 'favorite';
  final Database _db = CatsDatabase().database;

  get count => _favorites.length;

  FavoritesRepository() {
    _db.query(_tableName).then((datas) {
      _favorites = datas.map((e) => Breed.fromMap(e)).toList();
      notifyListeners();
    });
  }

  add(Breed breed) {
    _favorites.add(breed);
    _db.insert(_tableName, breed.toMap());
    notifyListeners();
  }

  remove(Breed breed) {
    _favorites.remove(breed);
    _db.delete(_tableName,
      where: 'id=?',
      whereArgs: [breed.id],);
    notifyListeners();
  }

  get(int index) => _favorites[index];

  isFavorite(Breed breed) {
    return _favorites.contains(breed);
  }

}