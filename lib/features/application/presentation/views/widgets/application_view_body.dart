import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/application/presentation/views/widgets/application_card.dart';

class ApplicationViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        if (state is ApplicationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ApplicationSuccess) {
          if (state.applications.isEmpty) {
            return const Center(
              child: Text('No opportunities found'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16), // Ensure no padding above the list
              shrinkWrap: true,
              itemCount: state.applications.length,
              itemBuilder: (context, index) {
                return ApplicationCard(
                  title: state.applications[index].opportunity?.title ?? ' ',
                  dateRange:
                      '${state.applications[index].opportunity?.from ?? ' '}'
                      ' - ${state.applications[index].opportunity?.to ?? ' '}',
                  status: state.applications[index].status ?? '',
                  imageUrl: 'assets/shelter.jpg',
                );
              },
            );
          }
        } else if (state is ApplicationError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
