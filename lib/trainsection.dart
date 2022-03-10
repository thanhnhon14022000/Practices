import 'package:flutter/material.dart';

class Transaction {
  String content;
  double amount;
  DateTime createdDate;
  //constructor
  Transaction({required this.content, required this.amount, required this.createdDate});

  @override
  String toString() {
    // TODO: implement toString
    return 'content: $content, amount: $amount';
  }

  void add(Transaction transaction) {}

  map(ListTile Function(dynamic eachTransaction) param0) {}
}

