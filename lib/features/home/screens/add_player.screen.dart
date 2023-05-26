import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The statelessWidget that handles the current screen
class AddPlayerScreen extends HookWidget {
  /// The constructor.
  const AddPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addPlayerScreen = useState(true);
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
                      text: 'Add Player',
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: GestureDetector(
                  onTap: () {
                    addPlayerScreen.value = true;
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: addPlayerScreen.value
                          ? const Color(0xffF5F8FB)
                          : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Add Player',
                        color: addPlayerScreen.value
                            ? TAColors.textColor
                            : const Color(0x0D253C4D).withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 150,
                child: GestureDetector(
                  onTap: () {
                    addPlayerScreen.value = false;
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: !addPlayerScreen.value
                          ? const Color(0xffF5F8FB)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Search Player',
                        color: !addPlayerScreen.value
                            ? TAColors.textColor
                            : const Color(0x0D253C4D).withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffF5F8FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: addPlayerScreen.value
                    ? const _AddPlayerWidget()
                    : const _SearchPlayerWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPlayerWidget extends HookWidget {
  const _AddPlayerWidget();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final makeAdmin = useState(false);
    return Column(
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
                label: 'E-mail',
                textEditingController: emailController,
                placeholder: 'Enter your email',
              ),
              const SizedBox(height: 10),
              TAPrimaryInput(
                label: 'Phone',
                textEditingController: phoneController,
                placeholder: 'Enter the phone number',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Switch.adaptive(
                    value: makeAdmin.value,
                    activeColor: const Color(0xff586DF4),
                    onChanged: (v) {
                      makeAdmin.value = v;
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TATypography.subparagraph(
                      text: 'Make an administator',
                      color: const Color(0xff999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TAPrimaryButton(
            text: 'ADD',
            height: 50,
            mainAxisAlignment: MainAxisAlignment.center,
            onTap: () {},
          ),
        ),
        const SizedBox(height: 30),
        TATypography.paragraph(
          text: 'Go to teams',
          underline: true,
          color: TAColors.textColor,
        ),
      ],
    );
  }
}

class _SearchPlayerWidget extends HookWidget {
  const _SearchPlayerWidget();

  @override
  Widget build(BuildContext context) {
    final sportController = useTextEditingController();
    final levelController = useTextEditingController();
    final positionController = useTextEditingController();
    final stateController = useTextEditingController();
    final cityController = useTextEditingController();
    return Column(
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
              TADropdown(
                label: 'Sport',
                textEditingController: sportController,
                placeholder: 'Select the sport',
                items: const ['Football', 'Basketball'],
              ),
              const SizedBox(height: 10),
              TADropdown(
                label: 'Level',
                textEditingController: levelController,
                placeholder: 'Select a level',
                items: const ['Elite', 'Amateur'],
              ),
              const SizedBox(height: 20),
              TADropdown(
                label: 'Position',
                textEditingController: positionController,
                placeholder: 'Select a position',
                items: const [
                  'Goalkeeper',
                  'Defender',
                  'Midfielder',
                  'Forward'
                ],
              ),
              const SizedBox(height: 20),
              TADropdown(
                label: 'State',
                textEditingController: stateController,
                placeholder: 'Select a state',
                items: const ['Lagos', 'Abuja', 'Kano'],
              ),
              const SizedBox(height: 20),
              TADropdown(
                label: 'City',
                textEditingController: cityController,
                placeholder: 'Select a city',
                items: const ['Lagos', 'Abuja', 'Kano'],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TAPrimaryButton(
            text: 'SEARCH',
            height: 50,
            mainAxisAlignment: MainAxisAlignment.center,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
