import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/features/signup/presentation/managers/cubit/sign_up_cubit.dart';

class CustomButtonRole extends StatefulWidget {
  const CustomButtonRole({super.key});

  @override
  State<CustomButtonRole> createState() => _CustomButtonRoleState();
}

class _CustomButtonRoleState extends State<CustomButtonRole> {
  String? selectedRole;

  void _toggleButtons(String role) {
    setState(() {
      selectedRole = role;
    });
    context.read<SignUpCubit>().selectValue(role);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: CustomButton(
          text: 'Tourist',
          size: 16,
          heigh: 50,
          isSelected: selectedRole == 'Tourist',
          onTap: () => _toggleButtons('Tourist'),
        ),
      ),
      Expanded(
        child: CustomButton(
          text: 'Host',
          size: 16,
          heigh: 50,
          isSelected: selectedRole == 'Host',
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
