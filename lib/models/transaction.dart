class Transaction {
  final String idOfTransaction;
  final String titleOfTransaction;
  final double amountOfTransaction;
  final DateTime dateOfTransaction;
  Transaction(
      {required this.idOfTransaction,
      required this.titleOfTransaction,
      required this.amountOfTransaction,
      required this.dateOfTransaction});
}
//not a custom widget just tells how a transaction should look like 