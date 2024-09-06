import 'package:exo4/components.dart';
import 'package:exo4/consts.dart';
import 'package:exo4/repositories/login_state.dart';
import 'package:exo4/model/car.dart';
import 'package:exo4/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetailsPage extends StatefulWidget {
  Car? car;
  CarDetailsPage({this.car, super.key});

  @override
  State<StatefulWidget> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  late final TextEditingController _makeController;
  late final TextEditingController _modelController;
  String? _makeError;
  String? _modelError;

  @override
  void initState() {
    super.initState();
    _makeController = TextEditingController();
    _modelController = TextEditingController();
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  _insert() {

  }


  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(appTitle),
        ),
        drawer: const MyDrawer(),
        body: Consumer<LoginState>(
          builder: (context, loginState, child) {
            if (!loginState.connected) return Container();
            return Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                TextField(
                    controller: _makeController,
                    style: defaulTextStyle,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Make',
                        errorText: _makeError
                    )),
                TextField(
                    controller: _modelController,
                    style: defaulTextStyle,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Model',
                        errorText: _modelError
                    )),
                SizedBox(
                    width: double.infinity,
                    child:MyPadding(
                        child: ElevatedButton(
                            onPressed: _insert,
                            child: MyText(widget.car == null ? 'Create' : 'Update')))),
            ]));
          },
        )));
  }
}