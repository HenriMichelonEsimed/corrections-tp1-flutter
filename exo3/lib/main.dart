import 'package:exo3/components.dart';
import 'package:exo3/consts.dart';
import 'package:exo3/database.dart';
import 'package:exo3/models/breed.dart';
import 'package:exo3/repositories/favorites.dart';
import 'package:exo3/services/catapi.dart';
import 'package:exo3/widgets/breed_tap.dart';
import 'package:exo3/widgets/favorites_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CatsDatabase().open();
  runApp(ChangeNotifierProvider(
    create: (context) => FavoritesRepository(),
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  final catAPI = CatAPI();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Breed>> _breeds;

  @override
  void initState() {
    super.initState();
    _breeds = widget.catAPI.breeds();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
    Column(children: [
        Expanded(child:
          FutureBuilder(
            future: _breeds,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return ListView.builder(
                  padding: defaultPadding,
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                    BreedTap(
                        breed: data[index],
                        child:Card(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyPadding(child: MyText(data[index].toString())),
                            if (data[index].image != null)
                              Padding(
                                padding: defaultPaddingAll,
                                child: Image.network(data[index].image!.url,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fill,
                                  loadingBuilder:(context, child, progress) {
                                    if (progress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      heightFactor: 4,
                                      child: CircularProgressIndicator());
                                  }))
                        ]))
                ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
    ),
        const FavoritesBar()
    ])));
  }
}
