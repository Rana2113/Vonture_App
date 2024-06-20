import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/login/presentation/views/widgets.dart/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              PrimaryColor.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
          color: const Color(0xff002F44).withOpacity(0.9),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 88.0, left: 75, right: 75),
                  child: Text(
                    'Vonture',
                    style: Styles.textlogo,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: 450,
                    height: 20,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Travel with Purpose, Volunteer with Heart!',
                        textAlign: TextAlign.center,
                        style: Styles.text20w400,
                      ),
                    ),
                  ),
                ),
                verticalSpacing(67),
                const LoginViewBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
