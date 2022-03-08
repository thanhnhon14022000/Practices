// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'trainsection.dart';

//You can define your own Widget
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

//This is a "very basic" statefulwidget
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // ignore: unnecessary_new
  final GlobalKey<ScaffoldState> _scaffooldKey = GlobalKey<ScaffoldState>();
  final _contentControler = TextEditingController();
  final _finalControler = TextEditingController();

  // ignore: prefer_final_fields, unused_field
  Transaction _transaction = Transaction(content: '', amount: 0.0);
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "This is a StatefulWidget",
        home: Scaffold(
            key: _scaffooldKey,
            body: SafeArea(
              minimum: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextField(
                      controller: _contentControler,
                      decoration: const InputDecoration(
                        labelText: 'Hang can mua',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _transaction.content = text;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: _finalControler,
                      decoration: const InputDecoration(
                        labelText: 'Gia',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _transaction.amount = double.tryParse(text) ?? 0;
                        });
                      },
                    ),
                  ),
                  FlatButton(
                    child: const Text("Xin hay nhan nut"),
                    color: Colors.pinkAccent,
                    onPressed: () {
                      setState(() {
                        _transaction.add(_transaction);
                        _transaction.content = "";
                        _transaction.amount = 0.0;
                      });
                      _scaffooldKey.currentState!.showSnackBar(
                        SnackBar(
                          content: Text(
                              'transaction list:'+_transaction.toString()),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      // ignore: avoid_print
                      //print("Ten hang da mua: $_content, So tien: $_amount");
                    },
                  )
                ],
              ),
            )));
  }
}
