import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/collaborators/controllers/collaborators.controller.dart';
import 'package:team_aid/features/collaborators/widgets/collaborator.widget.dart';
import 'package:team_aid/main.dart';

/// The statelessWidget that handles the current screen
class CollaboratorsScreen extends ConsumerStatefulWidget {
  /// The constructor.
  const CollaboratorsScreen({super.key});

  @override
  ConsumerState<CollaboratorsScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends ConsumerState<CollaboratorsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(collaboratorsControllerProvider.notifier).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final collaboratorsList = ref.watch(collaboratorsControllerProvider).collaboratorsList;
    final prefs = ref.watch(sharedPrefs);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Iconsax.arrow_left_2,
                      color: TAColors.textColor,
                    ),
                    const Spacer(),
                    TATypography.h3(
                      text: 'Collaborators',
                      color: TAColors.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                    const Spacer(),
                    // const Icon(
                    //   Iconsax.menu_1,
                    //   color: TAColors.textColor,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF5F8FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: collaboratorsList.when(
                data: (data) {
                  return prefs.when(
                    data: (prefs) {
                      if (data.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: TATypography.paragraph(
                              text: 'No collaborators members added yet',
                              color: TAColors.purple,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: data.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return CollaboratorWidget(
                              collaboratorModel: data[index],
                              sharedPreferences: prefs,
                            );
                          },
                        );
                      }
                    },
                    error: (_, __) => const SizedBox(),
                    loading: () => const SizedBox(),
                  );
                },
                error: (_, __) => const SizedBox(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TAPrimaryButton(
                text: 'ADD COLLABORATOR',
                height: 50,
                mainAxisAlignment: MainAxisAlignment.center,
                onTap: () {
                  context.push(AppRoutes.createCollaborator);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
