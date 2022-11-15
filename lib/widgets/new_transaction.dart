import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == Null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

//Future sre classes that will give us an output in the future
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              // onChanged: (val) {
              //   titleInput = val;
              // },
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: 'Enter Transaction Title Here',
                  labelStyle: TextStyle(color: Colors.purple),
                  floatingLabelStyle: TextStyle(color: Colors.purple)),
              cursorColor: Colors.purple,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              // onChanged: (value) => {amountInput = value},
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Transaction Amount Here',
                labelStyle: TextStyle(color: Colors.purple),
                floatingLabelStyle: TextStyle(color: Colors.purple),
              ),
              cursorColor: Colors.purple,
              onSubmitted: (_) => _submitData,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    (_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'The Chosen Date is ${DateFormat.yMd().format(_selectedDate as DateTime)}'),
                  ),
                ),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  iconSize: 35,
                )
              ],
            ),
            TextButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.purple),
                ),
                style: TextButton.styleFrom(
                    textStyle: TextStyle(
                  fontSize: 15,
                )))
          ],
        ),
      ),
    );
  }
}
