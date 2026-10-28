import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/data/models/event_model.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_registrations_cubit/event_registrations_cubit.dart';
import 'package:share_plus/share_plus.dart';

class ShareRegistrationsButton extends StatelessWidget {
  final String serializedEventInfo;
  const new({required this.serializedEventInfo, super.key});

  @override
  Widget build(BuildContext context) {
    final eventDetails = EventModel.fromJson(serializedEventInfo);

    return BlocBuilder<EventRegistrationsCubit, EventRegistrationsState>(
      buildWhen: (p, c) {
        final isFetched =
            p.registrationFetchStatus != c.registrationFetchStatus;
        final isModified =
            p.registrationModificationStatus !=
            c.registrationModificationStatus;

        if (isFetched || isModified) return true;

        return false;
      },
      builder: (context, state) {
        return RawMaterialButton(
          onPressed: state.registrationFetchStatus.isSuccess
              ? () async {
                  final text = StringBuffer();
                  text.write("${eventDetails.title}\n\n");

                  final setNames = state.allRegistrations
                      .map((e) => '${e.counter}- ${e.user.name}\n')
                      .toSet();
                  text.writeAll(setNames);

                  final params = ShareParams(text: text.toString());

                  SharePlus.instance.share(params);
                }
              : null,
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(Icons.share, color: context.colorScheme.onSurface),
        );
      },
    );
  }
}
