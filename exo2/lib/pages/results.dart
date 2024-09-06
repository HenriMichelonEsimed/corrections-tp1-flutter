import 'package:exo2/components.dart';
import 'package:exo2/consts.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  final String operation;

  const ResultsPage(this.operation, {super.key});

  @override
  State<StatefulWidget> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(appTitle),
      ),
      body: Center(child: MyText(widget.operation)));
  }

}