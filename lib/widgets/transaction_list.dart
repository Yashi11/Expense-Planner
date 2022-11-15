import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      //List View doesnt have a fixed height, it has an infinite height and thus
      // it must be bounded by a Container widget which has a constrained height
      child: transactions.isEmpty
          ? Column(children: <Widget>[
              Text(
                'No Transactions Added Yet',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 300,
                child: Image.asset('assets/image/waiting.png'),
              )
            ])
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColorLight,
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                                child: Text(
                              '\$ ${transactions[index].amountOfTransaction.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.purple,
                              ),
                            )),
                          )),
                      title: Text(transactions[index].titleOfTransaction,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          )),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(transactions[index].dateOfTransaction),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ));
              },
              itemCount: transactions.length,
              //mapping widgets o another widget
            ),
    );
  }
}
// Card(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 15,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(width: 2, color: Colors.purple),
//                         ),
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           '\$ ${transactions[index].amountOfTransaction.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25,
//                             color: Colors.purple,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(transactions[index].titleOfTransaction,
//                               style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                               )),
//                           Text(
//                             DateFormat.yMMMd()
//                                 .format(transactions[index].dateOfTransaction),
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );