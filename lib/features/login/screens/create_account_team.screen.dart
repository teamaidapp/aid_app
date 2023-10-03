import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/login/controllers/createAccount.controller.dart';

/// The statelessWidget that handles the current screen
class CreateAccountTeamScreen extends StatelessWidget {
  /// The constructor.
  const CreateAccountTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    // const Icon(
                    //   Iconsax.arrow_left_2,
                    //   color: TAColors.textColor,
                    // ),
                    const Spacer(),
                    TATypography.h3(
                      text: 'Create a team',
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
            child: HookBuilder(
              builder: (context) {
                final teamNameController = useTextEditingController();
                final sportController = useTextEditingController();
                final levelController = useTextEditingController();
                final genderController = useTextEditingController();
                final organizationController = useTextEditingController(text: '');
                final countryController = useTextEditingController();
                final zipCodeController = useTextEditingController();
                final stateController = useTextEditingController();
                final currentSelectedState = useState('');
                final cityState = useState('');

                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffF5F8FB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TAContainer(
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 30,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TAPrimaryInput(
                                label: 'Team name',
                                textEditingController: teamNameController,
                                placeholder: 'Enter your team name',
                              ),
                              const SizedBox(height: 10),
                              TADropdown(
                                label: 'Sport',
                                placeholder: 'Select your sport',
                                items: TAConstants.sportsList,
                                onChange: (selectedValue) {
                                  if (selectedValue != null) {
                                    sportController.text = selectedValue.item;
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              // TADropdown(
                              //   label: 'Level',
                              //   placeholder: 'Select level',
                              //   items: TAConstants.ageGroupList,
                              //   onChange: (selectedValue) {
                              //     if (selectedValue != null) {
                              //       levelController.text = selectedValue.item;
                              //     }
                              //   },
                              // ),
                              TAPrimaryInput(
                                label: 'Level',
                                textEditingController: levelController,
                                placeholder: 'Enter the level',
                              ),
                              const SizedBox(height: 10),
                              TADropdown(
                                label: 'Select gender',
                                placeholder: 'Select gender',
                                items: TAConstants.genderList,
                                onChange: (selectedValue) {
                                  if (selectedValue != null) {
                                    genderController.text = selectedValue.item;
                                  }
                                },
                              ),
                              // const SizedBox(height: 10),
                              // TAPrimaryInput(
                              //   label: 'Organization',
                              //   textEditingController: organizationController,
                              //   placeholder: 'Enter your organization',
                              // ),
                              // const SizedBox(height: 10),
                              // TAPrimaryInput(
                              //   label: 'Country',
                              //   textEditingController: countryController,
                              //   placeholder: 'Enter your country',
                              // ),
                              // const SizedBox(height: 10),
                              // TAPrimaryInput(
                              //   label: 'Zip Code',
                              //   textEditingController: zipCodeController,
                              //   placeholder: 'Enter the zipcode',
                              //   inputListFormatter: [
                              //     FilteringTextInputFormatter.digitsOnly,
                              //     LengthLimitingTextInputFormatter(5),
                              //   ],
                              // ),
                              // const SizedBox(height: 10),
                              // TADropdown(
                              //   label: 'State',
                              //   placeholder: 'Select a state',
                              //   items: List.generate(
                              //     TAConstants.statesList.length,
                              //     (index) => TADropdownModel(
                              //       item: TAConstants.statesList[index].name,
                              //       id: TAConstants.statesList[index].id,
                              //     ),
                              //   ),
                              //   onChange: (selectedValue) {
                              //     if (selectedValue != null) {
                              //       stateController.text = selectedValue.id;
                              //       currentSelectedState.value = selectedValue.id;
                              //     }
                              //   },
                              // ),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     TATypography.paragraph(
                              //       text: 'City',
                              //       fontWeight: FontWeight.w500,
                              //       color: TAColors.color1,
                              //     ),
                              //     SizedBox(height: 0.5.h),
                              //     DropdownSearch<TADropdownModel>(
                              //       asyncItems: (filter) async {
                              //         final response = await http.get(
                              //           Uri.parse(
                              //             '${dotenv.env['API_URL']}/cities/cities/${currentSelectedState.value}',
                              //           ),
                              //         );

                              //         if (response.statusCode == 200) {
                              //           final data = (jsonDecode(response.body) as Map)['data'] as List;
                              //           final list = data.map((e) {
                              //             final taDropdownModel = TADropdownModel(
                              //               item: (e as Map)['name'] as String,
                              //               id: e['id'] as String,
                              //             );
                              //             return taDropdownModel;
                              //           }).toList()
                              //             ..sort((a, b) => a.item.compareTo(b.item));
                              //           return list;
                              //         } else {
                              //           return [];
                              //         }
                              //       },
                              //       onChanged: (value) {
                              //         if (value != null) {
                              //           cityState.value = value.id;
                              //         }
                              //       },
                              //       itemAsString: (item) => item.item,
                              //       dropdownButtonProps: const DropdownButtonProps(
                              //         icon: Icon(
                              //           Iconsax.arrow_down_1,
                              //           size: 14,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //       dropdownDecoratorProps: DropDownDecoratorProps(
                              //         baseStyle: GoogleFonts.poppins(
                              //           fontSize: 16.sp,
                              //           fontWeight: FontWeight.w500,
                              //           color: TAColors.color2,
                              //         ),
                              //         dropdownSearchDecoration: InputDecoration(
                              //           hintText: 'Select a city',
                              //           contentPadding: const EdgeInsets.symmetric(
                              //             horizontal: 10,
                              //             vertical: 10,
                              //           ),
                              //           border: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(10),
                              //             borderSide: BorderSide(
                              //               color: TAColors.color1.withOpacity(0.5),
                              //             ),
                              //           ),
                              //           enabledBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(10),
                              //             borderSide: BorderSide(
                              //               color: TAColors.color1.withOpacity(0.5),
                              //             ),
                              //           ),
                              //           focusedBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(10),
                              //             borderSide: const BorderSide(
                              //               color: TAColors.color1,
                              //             ),
                              //           ),
                              //           hintStyle: GoogleFonts.poppins(
                              //             fontSize: 16.sp,
                              //             fontWeight: FontWeight.w500,
                              //             color: TAColors.color2,
                              //           ),
                              //         ),
                              //       ),
                              //       popupProps: PopupProps.menu(
                              //         fit: FlexFit.loose,
                              //         constraints: const BoxConstraints.tightFor(),
                              //         menuProps: MenuProps(
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 40,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    context.go(AppRoutes.home);
                                  },
                                  child: TATypography.paragraph(
                                    text: 'Skip',
                                    underline: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: HookConsumer(
                                  builder: (context, ref, child) {
                                    final isLoading = useState(false);
                                    return TAPrimaryButton(
                                      text: 'CREATE TEAM',
                                      height: 50,
                                      isLoading: isLoading.value,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      onTap: () async {
                                        if (teamNameController.text.isEmpty ||
                                                sportController.text.isEmpty ||
                                                levelController.text.isEmpty ||
                                                genderController.text.isEmpty
                                            // organizationController.text.isEmpty ||
                                            // countryController.text.isEmpty ||
                                            // zipCodeController.text.isEmpty ||
                                            // stateController.text.isEmpty ||
                                            // cityState.value.isEmpty
                                            ) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Please fill all the fields'),
                                            ),
                                          );
                                          return;
                                        }

                                        isLoading.value = true;
                                        final team = TeamModel(
                                          id: '',
                                          teamName: teamNameController.text,
                                          sport: sportController.text,
                                          level: levelController.text,
                                          gender: genderController.text,
                                          organization: organizationController.text,
                                          country: countryController.text,
                                          zipCode: zipCodeController.text,
                                          state: stateController.text,
                                          city: cityState.value,
                                        );
                                        final res = await ref
                                            .read(
                                              createAccountControllerProvider.notifier,
                                            )
                                            .createTeam(team: team);
                                        isLoading.value = false;
                                        if (res.ok && context.mounted) {
                                          context.go(AppRoutes.addCoach);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(res.message),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
