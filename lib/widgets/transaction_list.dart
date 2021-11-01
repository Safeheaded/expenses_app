import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this._transactions, this._deleteTransaction);

  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text('No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text('\$${_transactions[index].amount}')),
                    ),
                  ),
                  title: Text(_transactions[index].title,
                      style: Theme.of(context).textTheme.title),
                  subtitle: Text(
                      DateFormat.yMMMd().format(_transactions[index].date)),
                  trailing: mediaQuery.size.width > 360
                      ? TextButton.icon(
                          onPressed: () =>
                              _deleteTransaction(_transactions[index].id),
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          label: Text(
                            'Delete',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ))
                      : IconButton(
                          onPressed: () =>
                              _deleteTransaction(_transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
