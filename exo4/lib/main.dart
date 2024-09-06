import 'package:exo4/components.dart';
import 'package:exo4/consts.dart';
import 'package:exo4/repositories/login_state.dart';
import 'package:exo4/pages/car_detail.dart';
import 'package:exo4/pages/login.dart';
import 'package:exo4/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(ChangeNotifierProvider(
      create: (context) => LoginState(),
      lazy: false,
      child: const MyApp()));
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
      home: Consumer<LoginState>(builder: (context, loginState, child) {
        return loginState.connected ? const MyHomePage() : LoginPage();
      })
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(appTitle),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarDetailsPage())),
        child: const Icon(Icons.add),
      ),
      body: Consumer<LoginState>(
        builder: (context, loginState, child) {
          if (!loginState.connected) return Container();
          return Center(child: MyText(Provider.of<LoginState>(context).token!));
        },
      )));


  }
}
