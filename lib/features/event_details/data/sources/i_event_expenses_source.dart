import 'package:pay_pilot_plus/core/data/params/event_expense_params.dart';

abstract class IEventExpensesSource<TList, TInt, TExpense> {
  Future<TList> fetchAllExpenses(int eventID);
  Future<TExpense> insertExpenseSettledByStaff(EventExpenseParams params);
  Future<TExpense> insertExpenseSettledByBank(EventExpenseParams params);
  Future<TInt> deleteExpense(String series);
}
