import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/login/controllers/createAccount.controller.dart';

/// The statelessWidget that handles the current screen
class CreateAccountTeamPlayerScreen extends StatelessWidget {
  /// The constructor.
  const CreateAccountTeamPlayerScreen({
    required this.isCreatingSon,
    super.key,
  });

  /// If the user is creating a son or not.
  final bool isCreatingSon;

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
                    const Icon(
                      Iconsax.arrow_left_2,
                      color: TAColors.textColor,
                    ),
                    const Spacer(),
                    TATypography.h3(
                      text: isCreatingSon ? 'Parent' : 'Player',
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
                final firstNameController = useTextEditingController();
                final lastNameController = useTextEditingController();
                final emailController = useTextEditingController();
                final phoneNumberController = useTextEditingController();
                final passwordController = useTextEditingController();
                final agreeToTerms = useState(false);
                final sport = useState('');
                final cityState = useState('');
                final currentSelectedState = useState('');
                // final address = useState('');
                final googleAddress = useState('');
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
                                label: 'First name',
                                textEditingController: firstNameController,
                                placeholder: 'Enter your first name',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Last name',
                                textEditingController: lastNameController,
                                placeholder: 'Enter your last name',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'E-mail',
                                textEditingController: emailController,
                                placeholder: 'Enter your email',
                              ),
                              // const SizedBox(height: 10),
                              // TADropdown(
                              //   label: 'Sports',
                              //   items: TAConstants.sportsList,
                              //   placeholder: 'Select your sport',
                              //   onChange: (v) {
                              //     if (v != null) {
                              //       sport.value = v.id;
                              //     }
                              //   },
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
                              //       currentSelectedState.value = selectedValue.id;
                              //     }
                              //   },
                              // ),
                              // const SizedBox(height: 10),
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
                              TAPrimaryInput(
                                label: 'Phone number',
                                textEditingController: phoneNumberController,
                                placeholder: 'Enter your phone number',
                                inputListFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(12),
                                  PhoneInputFormatter(defaultCountryCode: 'US')
                                ],
                              ),
                              const SizedBox(height: 10),
                              // if (!isCreatingSon)
                              //   LocationWidget(
                              //     title: 'Address',
                              //     onChanged: (v) {
                              //       if (v != null) {
                              //         address.value = v.item;
                              //         googleAddress.value = v.id;
                              //       }
                              //     },
                              //   ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Password',
                                textEditingController: passwordController,
                                isPassword: true,
                                placeholder: 'Enter your password',
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Switch.adaptive(
                                value: agreeToTerms.value,
                                activeColor: const Color(0xff586DF4),
                                onChanged: (v) {
                                  agreeToTerms.value = v;
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TATypography.subparagraph(
                                  text: 'I agree to terms of service and privacy policy',
                                  color: TAColors.grey1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        HookConsumer(
                          builder: (context, ref, child) {
                            final isLoading = useState(false);
                            return Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: TAPrimaryButton(
                                text: 'CREATE ACCOUNT',
                                height: 50,
                                isLoading: isLoading.value,
                                mainAxisAlignment: MainAxisAlignment.center,
                                onTap: () async {
                                  if (firstNameController.text.isEmpty ||
                                          lastNameController.text.isEmpty ||
                                          emailController.text.isEmpty ||
                                          phoneNumberController.text.isEmpty ||
                                          passwordController.text.isEmpty
                                      // sport.value.isEmpty
                                      ) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please fill all fields'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (!isValidEmail(emailController.text.trim())) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter a valid email'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (!agreeToTerms.value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please agree to terms of service and privacy policy',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  // if (!isValidPhoneNumber(phoneNumberController.text.trim())) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //       content: Text('Please enter a valid phone number'),
                                  //     ),
                                  //   );
                                  // return;
                                  // }

                                  final phone =
                                      phoneNumberController.text.replaceAll(' ', '').replaceAll('+', '').replaceAll('(', '').replaceAll(')', '');

                                  final user = UserModel(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text.toLowerCase().trim(),
                                    phoneNumber: phone,
                                    password: passwordController.text,
                                    sportId: sport.value,
                                    role: isCreatingSon ? Role.parent : Role.player,
                                    cityId: cityState.value,
                                    stateId: currentSelectedState.value,
                                    address: '',
                                    googleAddress: !isCreatingSon ? googleAddress.value : null,
                                  );
                                  isLoading.value = true;
                                  final res = await ref
                                      .read(
                                        createAccountControllerProvider.notifier,
                                      )
                                      .createAccount(user: user);
                                  isLoading.value = false;
                                  if (res.ok && context.mounted) {
                                    if (isCreatingSon) {
                                      context.go(AppRoutes.createAccountParents);
                                    } else {
                                      context.go(AppRoutes.joinTeam);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(res.message),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
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
