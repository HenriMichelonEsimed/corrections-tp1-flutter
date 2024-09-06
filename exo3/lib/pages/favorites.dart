import 'package:exo3/components.dart';
import 'package:exo3/consts.dart';
import 'package:exo3/repositories/favorites.dart';
import 'package:exo3/widgets/breed_tap.dart';
import 'package:exo3/widgets/favorite_button.dart';
import 'package:exo3/widgets/favorites_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(
        appBar: AppBar(
        title: const Text('Favoris'),
    ),
    body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Consumer<FavoritesRepository>(
          builder: (context, favorites, child) =>
            Expanded(child: ListView.builder(
              padding: defaultPaddingAll,
              itemCount: favorites.count,
              itemBuilder: (context, index){
                final breed = favorites.get(index);
                return Row(children:[
                  FavoriteButton(breed),
                  BreedTap(
                    breed: breed,
                    child: MyText(breed.toString()))
                ]);
              }))),
      const FavoritesBar()])
    ));
  }
}