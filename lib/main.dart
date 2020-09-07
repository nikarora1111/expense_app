import 'dart:io';
import 'package:expenseapp/widget/chart.dart';
import 'package:expenseapp/widget/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/user_transaction.dart';
import 'widget/new_transaction.dart';
import 'widget/transaction_list.dart';
import 'model/transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //if(platform)
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.grey,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    /*Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shirt',
      amount: 99.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Cup',
      amount: 60,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Mobile Recharge',
      amount: 450,
      date: DateTime.now(),
    ),*/
  ];

  void _addNewTransaction(String txTitle, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }
bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final row=Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('show chart'),
        Switch.adaptive(
          activeColor:Theme.of(context).accentColor,
          value:_showChart,
          onChanged: (val){
            setState(() {
              _showChart=val;
            });
          },),
      ],
    );
    final appBar = AppBar(
      //backgroundColor: Colors.purple,
      title: Text('My Flutter App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        )
      ],
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            .7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if(isLandscape)
              row,
            if(!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                      .3,
                  child: Chart(_recentTransactions)),
            if(!isLandscape)
              txListWidget,
            if(isLandscape) _showChart? Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                    .7,
                child: Chart(_recentTransactions)):
                txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS? Container():FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
