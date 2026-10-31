import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/core/l10n/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot_plus/core/utils/resources/app_routes.dart';
import 'package:pay_pilot_plus/core/widgets/app_bottom_modal_sheet.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot_plus/core/widgets/app_menu_tile.dart';
import 'package:pay_pilot_plus/features/change_language/presentation/widgets/change_language_modal_view.dart';
import 'package:pay_pilot_plus/features/settings/presentation/bloc/backup_bloc.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.settings_appBarTitle)),
      body: ListView(
        children: [
          // اطلاعات پایه: یک بار تعریف می‌شوند و کمتر تغییر می‌کنند
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: AppMenuSection(
              title: S.current.mainMenu_basicData,
              children: [
                AppMenuTile(
                  icon: Icons.groups_outlined,
                  title: S.current.button_title_teams,
                  onTap: () => context.pushNamed(AppRoutes.teamsScreen),
                ),
                AppMenuTile(
                  icon: Icons.restaurant_menu_outlined,
                  title: S.current.button_title_menuItems,
                  onTap: () => context.pushNamed(AppRoutes.menuItemsScreen),
                ),
              ],
            ),
          ),
          BlocConsumer<BackupBloc, BackupState>(
            listener: (context, state) {
              if (state.exportStatus is ExportFetched) {
                final exportedFile =
                    (state.exportStatus as ExportFetched).params;
                SharePlus.instance.share(exportedFile);

                context.read<BackupBloc>().add(ChangeToInit());
              }
              if (state.importStatus is ImportFetched) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.current.warning_operationSuccessful),
                  ),
                );

                context.read<BackupBloc>().add(ChangeToInit());
              }
              if (state.importStatus is ImportFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      (state.importStatus as ImportFailure).error.message!,
                    ),
                  ),
                );

                context.read<BackupBloc>().add(ChangeToInit());
              }
              if (state.exportStatus is ExportFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      (state.exportStatus as ExportFailure).error.message!,
                    ),
                  ),
                );

                context.read<BackupBloc>().add(ChangeToInit());
              }
              // if (state is BackupFailure) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text(
              //         '${S.current.warning_operationFailure} $state',
              //       ),
              //     ),
              //   );
              // } else if (state is BackupSuccess) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text(S.current.warning_operationSuccessful),
              //     ),
              //   );
              // }
            },
            builder: (context, state) {
              final isLoading =
                  state.exportStatus is ExportLoading ||
                  state.importStatus is ImportLoading;

              return GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(18),
                children: [
                  if (!kIsWeb) ...[
                    AppElevatedButton(
                      isSelected: isLoading,
                      onTap: () {
                        context.read<BackupBloc>().add(ExportBackupRequested());
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.current.button_title_backup,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    AppElevatedButton(
                      isSelected: isLoading,
                      onTap: () {
                        context.read<BackupBloc>().add(ImportBackupRequested());
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.current.button_title_restore,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                  AppElevatedButton(
                    onTap: () {
                      AppBottomModalSheet.minHeightWithAppBar(
                        header: S.current.button_title_changeLanguage,
                        child: ChangeLanguageModalView(),
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.current.modalBottom_title_changeLanguage,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
