import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot_plus/features/events/presentation/blocs/close_event_bloc/event_modification_bloc.dart';
import 'package:pay_pilot_plus/locator.dart';

class OpenEventModalView extends StatefulWidget {
  final EventModel eventModel;
  final Function(EventModel openedEvent) onSubmit;
  const new({required this.eventModel, required this.onSubmit, super.key});

  @override
  State<OpenEventModalView> createState() => _OpenEventModalViewState();
}

class _OpenEventModalViewState extends State<OpenEventModalView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventModificationBloc(locator()),
      child: Builder(
        builder: (context) {
          return BlocConsumer<EventModificationBloc, EventModificationState>(
            listenWhen: (p, c) => p.openEventStatus != c.openEventStatus,
            listener: (context, state) {
              if (state.openEventStatus is OpenEventSuccess) {
                widget.onSubmit(
                  widget.eventModel.copyWith(
                    isClosed: false,
                    entranceFee: BigInt.zero,
                    snacksFee: BigInt.zero,
                  ),
                );
                context.pop();
              }
            },
            builder: (context, state) {
              return AppModalColumnViewSkin(
                isLoading:
                    state.openEventStatus is OpenEventLoading ||
                    state.openEventStatus is OpenEventSuccess,
                onSubmit: () {
                  context.read<EventModificationBloc>().add(
                    OpenEvent(widget.eventModel.id),
                  );
                },
                children: [
                  Text(
                    S.current.event_openAccountConfirmation,
                    style: context.themeOf.textTheme.headlineLarge,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
