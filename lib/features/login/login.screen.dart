import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/components/buttons/primary_button.dart';
import 'package:team_aid/design_system/design_system.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Placeholder(fallbackHeight: 100),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    TATypography.h3(text: 'Welcome to Team Aid'),
                    SizedBox(height: 4.h),
                    const TAPrimaryInput(
                      label: 'Email',
                      placeholder: 'Enter your email',
                    ),
                    SizedBox(height: 2.h),
                    const TAPrimaryInput(
                      label: 'Password',
                      placeholder: 'Enter your password',
                    ),
                    SizedBox(height: 4.h),
                    TAPrimaryButton(
                      text: 'Login',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
