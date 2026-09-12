part of '../event_details_cubit.dart';

class FetchDetailStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDetailInitial extends FetchDetailStatus {}

class FetchDetailLoading extends FetchDetailStatus {}

class FetchDetailSuccess extends FetchDetailStatus {
  final EventModel eventDetails;

  FetchDetailSuccess(this.eventDetails);

  @override
  List<Object?> get props => [eventDetails];
}

class FetchDetailFailure extends FetchDetailStatus {}
