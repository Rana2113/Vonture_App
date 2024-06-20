import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/tourist_profile.dart';
import 'package:vonture_grad/features/application/presentation/views/widgets/get_all_application_card.dart';

class GetAllApplicationOpportunityBody extends StatefulWidget {
  const GetAllApplicationOpportunityBody(
      {super.key, required this.opportunityId});
  final int opportunityId;

  @override
  State<GetAllApplicationOpportunityBody> createState() =>
      _GetAllApplicationOpportunityBodyState();
}

class _GetAllApplicationOpportunityBodyState
    extends State<GetAllApplicationOpportunityBody> {
  @override
  void initState() {
    super.initState();
    context
        .read<ApplicationCubit>()
        .getallapplicationopportunity(widget.opportunityId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
        builder: (context, state) {
      if (state is GetallApplicationOpportunityLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: PrimaryColor,
          ),
        );
      } else if (state is GetallAplicationOpportunitySuccess) {
        if (state.applications.isEmpty) {
          return const Center(
            child: Text(
              'No applications yet!',
              style: Styles.text18w400,
            ),
          );
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.applications.length,
              itemBuilder: (context, index) {
                return GetAllApplicationCard(
                  name:
                      '${state.applications[index].tourist!.firstName} ${state.applications[index].tourist!.lastName}',
                  nationality:
                      state.applications[index].tourist!.nationality ?? '',
                  bio: state.applications[index].tourist!.bio ?? '',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TouristProfile(
                                  touristid:
                                      state.applications[index].tourist!.id!,
                                  opportunityId: widget.opportunityId,
                                  status: state.applications[index].status!,
                                )));
                  },
                );
              });
        }
      } else if (state is GetallApplicationOpportunityError) {
        return Center(
          child: Text(
            state.message,
            style: Styles.text18w400,
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: PrimaryColor,
        ),
      );
    });
  }
}
