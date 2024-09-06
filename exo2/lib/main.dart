import 'package:exo2/components.dart';
import 'package:exo2/consts.dart';
import 'package:exo2/database.dart';
import 'package:exo2/model/history_entry.dart';
import 'package:exo2/pages/results.dart';
import 'package:exo2/repositories/history_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HistoryDatabase().open();
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
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  final repo = HistoryEntryRepository();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  late double _value1;
  late double _value2;
  late Future<List<HistoryEntry>> _history;
  late final DateFormat _dateTimeFormat;
  late FocusNode _op1Focus;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting().then((value) =>
      _dateTimeFormat = DateFormat.yMd('fr').add_jm());
    _history = widget.repo.getAll();
    _op1Focus = FocusNode();
  }

  @override
  void dispose() {
    _op1Focus.dispose();
    super.dispose();
  }

  _displayResult(operation) {
    widget.repo.insert(HistoryEntry(operation));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResultsPage(operation)))
    .then((value) {
      setState(() {
        _formKey.currentState?.reset();
        _history = widget.repo.getAll();
        _op1Focus.requestFocus();
      });
    });
  }

  String? _operandValidator(value) {
      if (value == null ||
          value.trim().isEmpty ||
          double.tryParse(value) == null) {
        return 'Veuillez saisir un nombre';
      }
      return null;
    }

  _add() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult('$_value1 + $_value2 = ${_value1 + _value2}');
  }

  _sub() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult('$_value1 - $_value2 = ${_value1 - _value2}');
  }

  _mul() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult('$_value1 * $_value2 = ${_value1 * _value2}');
  }

  _div() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    _displayResult('$_value1 / $_value2 = ${_value1 / _value2}');
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    autofocus: true,
                    focusNode: _op1Focus,
                    keyboardType: TextInputType.number,
                    style: defaulTextStyle,
                    onSaved: (value) => _value1 = double.parse(value.toString()),
                    validator: _operandValidator,
                )),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: defaulTextStyle,
                    onSaved: (value) => _value2 = double.parse(value.toString()),
                    validator: _operandValidator
                )),
            ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MySizedBox(child: ElevatedButton(
                  onPressed: () => _add(),
                  child: MyText('+'),
                )),
                MySizedBox(child: ElevatedButton(
                  onPressed: () => _sub(),
                  child: MyText('-'),
                )),
                MySizedBox(child: ElevatedButton(
                  onPressed: () => _mul(),
                  child: MyText('*'),
                )),
                MySizedBox(child: ElevatedButton(
                  onPressed: () => _div(),
                  child: MyText('/'),
                ))
              ]),
          Expanded(child: FutureBuilder(
              future: _history,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return ListView.builder(
                      padding: defaultPadding,
                      itemCount: data.length,
                      itemBuilder:(context, index) =>
                          MyText('${_dateTimeFormat.format(data[index].date)} : ${data[index].operation}'));
                } else {
                  return const Text('Chargement...');
                }
            }))
      ])));
  }
}
