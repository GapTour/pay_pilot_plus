part of 'event_expenses_cubit.dart';

enum ExpensesFetchStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == ExpensesFetchStatus.initial;
  bool get isLoading => this == ExpensesFetchStatus.loading;
  bool get isSuccess => this == ExpensesFetchStatus.success;
  bool get isFailure => this == ExpensesFetchStatus.failure;
}

enum ExpenseModificationStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == ExpenseModificationStatus.initial;
  bool get isLoading => this == ExpenseModificationStatus.loading;
  bool get isSuccess => this == ExpenseModificationStatus.success;
  bool get isFailure => this == ExpenseModificationStatus.failure;
}

class EventExpensesState extends Equatable {
  final ExpensesFetchStatus expensesFetchStatus;
  final ExpenseModificationStatus expenseModificationStatus;
  final List<EventExpenseModel> allExpenses;

  const EventExpensesState({
    required this.expensesFetchStatus,
    required this.expenseModificationStatus,
    required this.allExpenses,
  });

  @override
  List<Object> get props => [
    expensesFetchStatus,
    expenseModificationStatus,
    allExpenses,
  ];

  EventExpensesState copyWith({
    ExpensesFetchStatus? expensesFetchStatus,
    ExpenseModificationStatus? expenseModificationStatus,
    List<EventExpenseModel>? allExpenses,
  }) {
    return EventExpensesState(
      expensesFetchStatus: expensesFetchStatus ?? this.expensesFetchStatus,
      expenseModificationStatus:
          expenseModificationStatus ?? this.expenseModificationStatus,
      allExpenses: allExpenses ?? this.allExpenses,
    );
  }
}
