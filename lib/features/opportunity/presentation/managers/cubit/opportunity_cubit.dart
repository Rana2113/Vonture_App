import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/models/opportunity_model/opportunity_model.dart';
import 'package:vonture_grad/features/opportunity/data/opportunity_repo_implementation.dart';

part 'opportunity_state.dart';

class OpportunityCubit extends Cubit<OpportunityState> {
  OpportunityCubit(this.opportunityRepoImplementation)
      : super(OpportunityInitial());

  final OpportunityRepoImplementation opportunityRepoImplementation;
  static OpportunityCubit get(context) => BlocProvider.of(context);

  Future<void> getallopportunity() async {
    emit(OpportunityLoading());
    print("HomeCubit: Home called");

    final response = await opportunityRepoImplementation.getallopportunity();
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

    final response =
        await opportunityRepoImplementation.searchOpportunity(query);
    print("HomesearchCubit: Search result: $response");

    response.fold(
      (failure) => emit(OpportunitySearchError(message: failure.toString())),
      (opportunities) {
        print("HomeCubit: Search successful - User: $opportunities");

        emit(OpportunitySearchSuccess(opportunities: opportunities));
      },
    );
  }

  Future<void> getSpecifiOpportunity(int id) async {
    emit(GetSpecifiOpportunityLoading());
    print("getspecifi: getspecific called");
    final response =
        await opportunityRepoImplementation.getSpecifiOpportunity(id);
    print("getspecifi: getspecific result: $response");

    response.fold(
        (failure) =>
            emit(GetSpecifiOpportunityError(message: failure.toString())),
        (detailsopportunity) {
      print("getspecifi: getspecific successful - User: $detailsopportunity");

      emit(
          GetSpecifiOpportunitySuccess(detailsopportunity: detailsopportunity));
    });
  }

  Future<void> applyOpportunity(int id) async {
    emit(ApplyOpportunityLoading());
    print("apply: apply called");
    final response = await opportunityRepoImplementation.applyOpportunity(id);
    getallopportunity();

    print("apply: apply result: $response");

    response.fold(
        (failure) => emit(ApplyOpportunityError(message: failure.toString())),
        (applyopportunity) {
      print("apply: apply successful - User: $applyopportunity");

      emit(ApplyOpportunitySuccess(applyopportunity: applyopportunity));
    });
  }
}
