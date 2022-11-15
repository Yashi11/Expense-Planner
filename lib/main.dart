import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Manager',
        home: MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.pinkAccent,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                    titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                )),
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold))));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleInput;
  final List<Transaction> _userTransactions = [
    Transaction(
        idOfTransaction: 'T1',
        titleOfTransaction: 'New Dress',
        amountOfTransaction: 69.99,
        dateOfTransaction: DateTime.now()),
    Transaction(
        idOfTransaction: 'T2',
        titleOfTransaction: 'Grocery',
        amountOfTransaction: 19.99,
        dateOfTransaction: DateTime.now())
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.dateOfTransaction.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
        idOfTransaction: DateTime.now().toString(),
        titleOfTransaction: txTitle,
        amountOfTransaction: txAmount,
        dateOfTransaction: txDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        // backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(
                Icons.add,
                color: Colors.purple,
                size: 40,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.purple,
          size: 40,
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
