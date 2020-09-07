import 'package:flutter/cupertino.dart';
import '../widget/new_transaction.dart';
import '../widget/transaction_list.dart';
import '../model/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('User Transaction Page'),
      ],
    );
  }
}
