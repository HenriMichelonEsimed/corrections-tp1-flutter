import 'package:exo1/components.dart';
import 'package:exo1/consts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  late final _name;

  _sayHello(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(
      content: MyText('Bonjour, $_name !'),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const MyText('Merci !'))
      ],
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('Hello, World!')
            /*Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Text('Hello, World!', style: TextStyle(fontSize: 20),)
              )*/
            //MyPadding(child: MyText('Hello, World!'))
            MyPadding(
              child: TextFormField(
                /*validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez saisir votre nom';
                  }
                  return null;
                },*/
                validator: (v) => stringNotEmptyValidator(v, 'Veuillez saisir votre nom'),
                onSaved: (value) => _name = value.toString(),
                decoration: const InputDecoration(hintText: 'Votre nom')
              )),
            SizedBox(
                width: double.infinity,
                child: MyPadding(child: ElevatedButton(
                    onPressed: () => _sayHello(context),
                    child: const MyText('Dire bonjour'))))
          ],
        ),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
