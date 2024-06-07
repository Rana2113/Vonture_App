import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/models/opportunity_model/opportunity_model.dart';
import 'package:vonture_grad/features/opportunity/data/opportunity_repo_implementation.dart';

part 'opportunity_state.dart';

class OpportunityCubit extends Cubit<OpportunityState> {
  OpportunityCubit(this.homeRepoImplementation) : super(OpportunityInitial());
  final OpportunityRepoImplementation homeRepoImplementation;
  static OpportunityCubit get(context) => BlocProvider.of(context);

  Future<void> getallopportunity() async {
    emit(OpportunityLoading());
    print("HomeCubit: Home called");

    final response = await homeRepoImplementation.getallopportunity();
    print("HomeCubit: Home result: $response");

    response.fold(
      (failure) => emit(OpportunityError(message: failure.toString())),
      (opportunityList) {
        print("HomeCubit: Home successful - User: $opportunityList");

        emit(OpportunitySuccessState(opportunityList: opportunityList));
      },
    );
  }

  Future<void> searchOpportunity(String query) async {
    emit(OpportunitySearchLoading());
    print("HomeCubit: Search called");

    final response = await homeRepoImplementation.searchOpportunity(query);
    print("HomeCubit: Search result: $response");

    response.fold(
      (failure) => emit(OpportunitySearchError(message: failure.toString())),
      (opportunities) {
        print("HomeCubit: Search successful - User: $opportunities");

        emit(OpportunitySearchSuccess(opportunities: opportunities));
      },
    );
  }
}
