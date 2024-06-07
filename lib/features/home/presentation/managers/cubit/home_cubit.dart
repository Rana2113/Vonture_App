import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/models/opportunity_model/opportunity_model.dart';
import 'package:vonture_grad/features/home/data/home_repo_implementation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepoImplementation) : super(HomeInitial());
  final HomeRepoImplementation homeRepoImplementation;
  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getallopportunity() async {
    emit(HomeLoading());
    print("HomeCubit: Home called");

    final response = await homeRepoImplementation.getallopportunity();
    print("HomeCubit: Home result: $response");

    response.fold(
      (failure) => emit(HomeError(message: failure.toString())),
      (opportunityList) {
        print("HomeCubit: Home successful - User: $opportunityList");

        emit(Homesucess(opportunityList: opportunityList));
      },
    );
  }

  Future<void> searchOpportunity(String query) async {
    emit(HomeSearchLoading());
    print("HomeCubit: Search called");

    final response = await homeRepoImplementation.searchOpportunity(query);
    print("HomeCubit: Search result: $response");

    response.fold(
      (failure) => emit(HomeSearchError(message: failure.toString())),
      (opportunities) {
        print("HomeCubit: Search successful - User: $opportunities");

        emit(HomeSearchsucess(opportunities: opportunities));
      },
    );
  }
}
