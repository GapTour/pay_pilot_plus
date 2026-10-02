import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot_plus/core/data/models/event_expense_model.dart';
import 'package:pay_pilot_plus/core/data/params/event_expense_params.dart';
import 'package:pay_pilot_plus/features/event_details/repository/event_details_repository.dart';

part 'event_expenses_state.dart';

class EventExpensesCubit extends Cubit<EventExpensesState> {
  final IEventDetailsRepository _repository;

  EventExpensesCubit(this._repository)
    : super(
        EventExpensesState(
          allExpenses: List.empty(),
          expensesFetchStatus: .initial,
          expenseModificationStatus: .initial,
        ),
      );

  Future<void> initExpenses(int eventID) async {
    emit(state.copyWith(expensesFetchStatus: .loading));

    final dataState = await _repository.fetchAllExpenses(eventID);

    if (dataState.isSuccess) {
      final allExpenses = List<EventExpenseModel>.from(dataState.response!);

      emit(
        state.copyWith(allExpenses: allExpenses, expensesFetchStatus: .success),
      );
    }

    if (dataState.isFailed) {
      emit(state.copyWith(expensesFetchStatus: .failure));
    }
  }

  void _changeModificationToInit() {
    emit(state.copyWith(expenseModificationStatus: .initial));
  }

  Future<void> insertExpense(EventExpenseParams params) async {
    emit(state.copyWith(expenseModificationStatus: .loading));

    final dataState = params.bankInfo == null
        ? await _repository.insertExpenseSettledByStaff(params)
        : await _repository.insertExpenseSettledByBank(params);

    if (dataState.isSuccess) {
      final allExpenses = List<EventExpenseModel>.from(state.allExpenses)
        ..add(dataState.response!);

      emit(
        state.copyWith(
          allExpenses: allExpenses,
          expenseModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(expenseModificationStatus: .failure));
    }
  }

  Future<void> deleteExpense(String series) async {
    emit(state.copyWith(expenseModificationStatus: .loading));

    final dataState = await _repository.deleteExpense(series);

    if (dataState.isSuccess) {
      final allExpenses = List<EventExpenseModel>.from(state.allExpenses)
        ..removeWhere((element) => element.series == series);

      emit(
        state.copyWith(
          allExpenses: allExpenses,
          expenseModificationStatus: .success,
        ),
      );
      _changeModificationToInit();
    }

    if (dataState.isFailed) {
      emit(state.copyWith(expenseModificationStatus: .failure));
    }
  }
}
