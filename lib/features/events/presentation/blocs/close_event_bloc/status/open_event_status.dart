part of '../event_modification_bloc.dart';

class OpenEventStatus extends Equatable {
  @override
  List<Object?> get props => [];
}

class OpenEventInitial extends OpenEventStatus {}

class OpenEventLoading extends OpenEventStatus {}

class OpenEventSuccess extends OpenEventStatus {}

class OpenEventFailure extends OpenEventStatus {
  final ErrorResponse error;

  new(this.error);
}
