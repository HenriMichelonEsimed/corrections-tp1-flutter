import 'package:exo3/models/breed.dart';
import 'package:exo3/pages/breed.dart';
import 'package:flutter/material.dart';

class BreedTap extends StatelessWidget {
  final Widget child;
  final Breed breed;
  const BreedTap({required this.child, required this.breed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BreedPage(breed))),
        child: child);
  }
}