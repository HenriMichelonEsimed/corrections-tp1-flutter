import 'package:exo3/consts.dart';
import 'package:exo3/models/breed.dart';
import 'package:exo3/repositories/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {

  final Breed breed;
  const FavoriteButton(this.breed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: defaultPaddingAll,
        child: Consumer<FavoritesRepository>(
            builder: (context, favorites, child) {
              return IconButton(
                  icon: Icon(favorites.isFavorite(breed) ? Icons.favorite : Icons.favorite_outline),
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                  onPressed: () {
                    if (favorites.isFavorite(breed)) {
                      favorites.remove(breed);
                    } else {
                      favorites.add(breed);
                    }
                  });
            }));
  }
}