import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/profile/models/transaction_model.dart';

abstract class ITransactionRepository {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> addTransaction(TransactionModel transaction);
}

class LocalTransactionRepository implements ITransactionRepository {
  final DatabaseHelper _dbHelper;

  LocalTransactionRepository({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<List<TransactionModel>> getTransactions() async {
    return await _dbHelper.readAllTransactions();
  }

  @override
  Future<TransactionModel> addTransaction(TransactionModel transaction) async {
    return await _dbHelper.createTransaction(transaction);
  }
}
