import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';

class SearchOpportunity extends StatefulWidget {
  const SearchOpportunity({super.key});

  @override
  _SearchOpportunityState createState() => _SearchOpportunityState();
}

class _SearchOpportunityState extends State<SearchOpportunity> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
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
                  color: PrimaryColor,
                  fontSize: 14,
                  height: 0.09,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: kBorderColor2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: TextColor,
                  ),
                ),
                contentPadding: const EdgeInsets.all(12),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
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
