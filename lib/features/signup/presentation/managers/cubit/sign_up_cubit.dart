import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/models/user_model.dart';
import 'package:vonture_grad/features/signup/data/sign_up_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());
  final SignUpRepo signUpRepo;
  static SignUpCubit get(context) => BlocProvider.of(context);

  Future<void> signUP({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String phonenumber,
    required String nationality,
    required String bio,
    required String birthdate,
    required String gender,
    required String role,
  }) async {
    emit(SignUpLoading());
    print("SignUpCubit: login called");

    String role;
    if (selectedValue == 'Tourist') {
      role = 'TOURIST';
    } else if (selectedValue == 'Host') {
      role = 'HOST';
    } else {
      role = '';
      print("SignUpCubit: Invalid role selected");
      emit(SignUpFailure("Invalid role selected"));
      return;
    }
    var result = await signUpRepo.signUp(
      firstname,
      lastname,
      email,
      password,
      phonenumber,
      nationality,
      bio,
      birthdate,
      gender,
      role,
    );
    print("SignUpCubit: login result: $result");
    result.fold(
      (failure) {
        emit(SignUpFailure(failure.errorMessages));
        print("SignUpCubit: login failed - Error: ${failure.errorMessages}");
      },
      (user) {
        print("SignUpCubit: login successful - User: $user");
        emit(SignUpSuccess(user));
      },
    );
  }

  String? selectedValue;
  void selectValue(String value) {
    selectedValue = value;
    emit(SignUpSelectValueState());
    print(selectedValue);
  }
}
