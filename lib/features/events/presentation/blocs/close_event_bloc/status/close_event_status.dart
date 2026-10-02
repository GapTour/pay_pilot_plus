part of '../event_modification_bloc.dart';

class CloseEventStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class CloseEventInitial extends CloseEventStatus {}

class CloseEventLoading extends CloseEventStatus {}

class CloseEventSuccess extends CloseEventStatus {
  final EventModel closedEvent;

  new(this.closedEvent);
}

class CloseEventFailure extends CloseEventStatus {
  final ErrorResponse error;

  new(this.error);
}
