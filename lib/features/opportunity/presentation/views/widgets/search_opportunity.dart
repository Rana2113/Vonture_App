import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';

class SearchOpportunity extends StatefulWidget {
  const SearchOpportunity({Key? key}) : super(key: key);

  @override
  _SearchOpportunityState createState() => _SearchOpportunityState();
}

class _SearchOpportunityState extends State<SearchOpportunity> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (value) {
                BlocProvider.of<OpportunityCubit>(context).searchOpportunity(
                  value,
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
                    color: kBorderColor2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kFocusBorder,
                  ),
                ),
                contentPadding: const EdgeInsets.all(12),
                filled: true,
                fillColor: kCardColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    // Clear the search field
                    searchController.clear();
                    // Return to the OpportunitySuccessState
                    BlocProvider.of<OpportunityCubit>(context)
                        .getallopportunity();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vonture_grad/core/constants.dart/colors.dart';
// import 'package:vonture_grad/features/opportunity/presentation/manager/cubit/opportunity_cubit.dart';

// class SearchOpportunity extends StatelessWidget {
//   const SearchOpportunity({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController searchController = TextEditingController();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: TextFormField(
//         onFieldSubmitted: (value) {
//           BlocProvider.of<OpportunityCubit>(context).searchOpportunity(
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
