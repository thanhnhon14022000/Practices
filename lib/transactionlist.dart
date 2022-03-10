import 'package:flutter/material.dart';
import 'trainsection.dart';

class TransationList extends StatelessWidget {
  final List<Transaction> transactions;

  TransationList({required this.transactions});
  ListView _buildListView() {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: (index - 1) % 2 == 0 ? Colors.green : Colors.amber,
        elevation: 10,
        child: ListTile(
          leading: const Icon(Icons.access_alarm),
          title: Text(
            transactions[index].content.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Price: ${transactions[index].amount}'),
          onTap: () {
            // ignore: avoid_print
            print('You clicked: ${transactions[index].content}');
          },
        ),
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
        height: 500,
        child: _buildListView()
        );
  }
}
