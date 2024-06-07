import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/home/presentation/managers/cubit/home_cubit.dart';

class SearchOpportunity extends StatelessWidget {
  const SearchOpportunity({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        onFieldSubmitted: (value) {
          BlocProvider.of<HomeCubit>(context).searchOpportunity(
            query: value,
          );
        },
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Find opportunities',
          hintStyle: const TextStyle(
            color: kLogoColor,
            fontSize: 14,
            height: 0.09,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xff96734F),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff96734F),
            ),
          ),
          contentPadding: const EdgeInsets.all(12),
          filled: true,
          fillColor: kCardColor,
        ),
      ),
    );
  }
}



















































// class SearchOpportunity extends StatelessWidget {
//   const SearchOpportunity({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController searchController = TextEditingController();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: TextFormField(
//         onFieldSubmitted: (value) {
//           BlocProvider.of<HomeCubit>(context).searchOpportunity(
//             value,
//           );
//         },
//         controller: searchController,
//         decoration: InputDecoration(
//           hintText: 'Find opportunities',
//           hintStyle: const TextStyle(
//             color: kLogoColor,
//             fontSize: 14,
//             height: 0.09,
//             fontWeight: FontWeight.w500,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(
//               color: Color(0xff96734F),
//             ),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xff96734F),
//             ),
//           ),
//           contentPadding: const EdgeInsets.all(12),
//           filled: true,
//           fillColor: kCardColor,
//         ),
//       ),
//     );
//   }
// }
