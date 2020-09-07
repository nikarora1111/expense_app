import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTX,
  }): super(key:key);
  final Transaction transaction;
  final Function deleteTX;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                  child: Text('\$${transaction.amount}')),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              DateFormat.yMMMd().format(transaction.date)),
          trailing: MediaQuery.of(context).size.width > 360
              ? FlatButton.icon(
            onPressed: () {
              deleteTX(transaction.id);
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
            label: Text(
              'Delete',
              style: TextStyle(
                  color: Theme.of(context).errorColor),
            ),
          )
              : IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteTX(transaction.id);
            },
            color: Theme.of(context).errorColor,
          )),
    );
  }
}
