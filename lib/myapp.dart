// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'trainsection.dart';
import 'transactionlist.dart';
import 'package:intl/intl.dart';

//You can define your own Widget
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

//This is a "very basic" statefulwidget
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  //define states
  Transaction _transaction =
      Transaction(content: '', amount: 0.0, createdDate: DateTime.now());
  final List<Transaction> _transactions = <Transaction>[];

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

  void _insertTrainsection() {
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0 ||
        _transaction.amount.isNaN) {
      return;
    }
    _transaction.createdDate = DateTime.now();
    _transactions.add(_transaction);
    _transaction =
        Transaction(content: '', amount: 0.0, createdDate: DateTime.now());
    _contentController.text = '';
    _amountController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "This is a StatefulWidget",
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Transaction manager'),
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // ignore: avoid_print
                      print('Chao mung');
                      setState(() {
                        _insertTrainsection();
                      });
                    }),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'add transection',
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _insertTrainsection();
                });
              },
            ),
            key: _scaffoldKey,
            body: SafeArea(
              minimum: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Content'),
                      controller: _contentController,
                      onChanged: (text) {
                        setState(() {
                          _transaction.content = text;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount(money)'),
                      controller: _amountController,
                      onChanged: (text) {
                        setState(() {
                          _transaction.amount =
                              double.tryParse(text) ?? 0; //if error, value = 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        child: Text(
                          'Insert Transaction',
                          style: const TextStyle(fontSize: 18),
                        ),
                        color: Colors.pinkAccent,
                        textColor: Colors.white,
                        onPressed: () {
                          //print('Content = $_content, money\'s amount = $_amount');
                          //Display to UI ?
                          //Now it must add the "transaction object" to a list of transactions(state)
                          setState(() {
                            _insertTrainsection();
                          });
                          //Now I want to display the list below
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                            content: Text('transaction list : ' +
                                _transactions.toString()),
                            duration: Duration(seconds: 3),
                          ));
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: TransationList(transactions: _transactions),
                    )
                  ],
                ),
              ),
            )));
  }
}
