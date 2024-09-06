import 'package:exo3/components.dart';
import 'package:exo3/consts.dart';
import 'package:exo3/models/breed.dart';
import 'package:exo3/models/image.dart' as image;
import 'package:exo3/services/catapi.dart';
import 'package:exo3/widgets/favorite_button.dart';
import 'package:exo3/widgets/favorites_bar.dart';
import 'package:flutter/material.dart';

class BreedPage extends StatefulWidget {
  final Breed breed;
  final catAPI = CatAPI();

  BreedPage(this.breed, {super.key});

  @override
  State<BreedPage> createState() => _BreedPageState();
}

class _BreedPageState extends State<BreedPage> {
  late Future<List<image.Image>> _images;

  @override
  void initState() {
    super.initState();
    _images = widget.catAPI.images(widget.breed);
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(
      appBar: AppBar(
        title: Text(widget.breed.name),
      ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FavoriteButton(widget.breed),
        Padding(padding: defaultPaddingAll,
          child: MyText(widget.breed.description)),
        Expanded(
            child: FutureBuilder(
              future: _images,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return ListView.builder(
                    padding: defaultPadding,
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                      Card(child:Padding(
                        padding: defaultPaddingAll,
                        child: Image.network(data[index].url,
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) {
                              return child;
                            }
                            return const Center(
                              heightFactor: 4,
                              child: CircularProgressIndicator());
                          },
                        )
                      )
                    ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            )),
        const FavoritesBar()
    ])));
  }

}