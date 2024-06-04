import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomAppBar(text: 'Create Account'),
        CustomImage(image: 'assets/Depth 1, Frame 0.png'),
        SizedBox(
          height: 40,
        ),
        CustomButtonRole(),
        SizedBox(
          height: 24,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomRowName(),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hinttext: 'Email',
                  icon: Icons.alternate_email,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hinttext: 'Password',
                  icon: Icons.password,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hinttext: 'Phone Number',
                  icon: Icons.phone_enabled_outlined,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hinttext: 'Country',
                  icon: FontAwesomeIcons.earthAfrica,
                  size: 20,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hinttext: 'Bio',
                  icon: Icons.notes,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hinttext: 'Birthday',
                  icon: Icons.calendar_month,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                  hinttext: 'Gender',
                  icon: FontAwesomeIcons.venusMars,
                  size: 20,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomButton2(
                  text: 'Next',
                  size: 24,
                  heigh: 48,
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomButton2 extends StatelessWidget {
  const CustomButton2(
      {super.key, required this.text, required this.size, required this.heigh});

  final String text;
  final double size, heigh;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xffF5C499),
          ),
          width: double.infinity,
          height: heigh,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: size, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRowName extends StatelessWidget {
  const CustomRowName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: CustomTextField(
          hinttext: 'First Name',
          icon: FontAwesomeIcons.circleUser,
        )),
        Expanded(
            child: CustomTextField(
          hinttext: 'Last Name',
          icon: FontAwesomeIcons.circleUser,
        ))
      ],
    );
  }
}

class CustomButtonRole extends StatefulWidget {
  const CustomButtonRole({super.key});

  @override
  State<CustomButtonRole> createState() => _CustomButtonRoleState();
}

class _CustomButtonRoleState extends State<CustomButtonRole> {
  bool isTouristSelected = false;
  bool isHostSelected = false;

  void _toggleButtons(String role) {
    setState(() {
      if (role == 'Tourist') {
        isTouristSelected = true;
        isHostSelected = false;
      } else if (role == 'Host') {
        isTouristSelected = false;
        isHostSelected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: CustomButton(
          text: 'Tourist',
          size: 16,
          heigh: 50,
          isSelected: isTouristSelected,
          onTap: () => _toggleButtons('Tourist'),
        ),
      ),
      Expanded(
        child: CustomButton(
          text: 'Host',
          size: 16,
          heigh: 50,
          isSelected: isHostSelected,
          onTap: () => _toggleButtons('Host'),
        ),
      ),
    ]);
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.size,
      required this.heigh,
      required this.isSelected,
      required this.onTap});
  final String text;
  final double size, heigh;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected == true
                ? const Color(0xffF5C499)
                : const Color.fromARGB(255, 228, 214, 203),
          ),
          width: double.infinity,
          height: heigh,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: size, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(
        child: Text(
          'Sign in',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: const Color(0xffFFFBF8),
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 218,
        decoration: BoxDecoration(
          image:
              DecorationImage(fit: BoxFit.fitWidth, image: AssetImage(image)),
        ));
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.hinttext, required this.icon, this.size = 24});
  final String hinttext;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(
            color: Color(0xff96734F),
            fontSize: 16,
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: size,
            ),
            disabledColor: Colors.black,
            color: const Color(0xff96734F),
          ),

          // filled: true,
          // fillColor: Color(0xffFFFBF8),
          border: buildOutlineInputBorder(
            const Color(0xffE8DBD1),
          ),
          focusedBorder: buildOutlineInputBorder(
            const Color(0xff96734F),
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color colorborder) {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: colorborder,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(16));
  }
}
// class CustomButtonRole extends StatelessWidget {
//   const CustomButtonRole({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: GestureDetector(
//         onTap: () {},
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: const Color(0xffF5C499),
//           ),
//           width: double.infinity,
//           height: 30,
//           child: const Center(
//             child: Text(
//               'tourit',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }