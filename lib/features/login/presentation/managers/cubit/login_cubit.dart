import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonture_grad/core/models/user_model.dart';
import 'package:vonture_grad/features/login/data/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;
  bool isPasswordVisible = true;
  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await loginRepo.login(email, password);
    result.fold((failure) => emit(LoginFailure(failure.errorMessages)), (user) {
      emit(LoginSuccess(user));
    });
  }

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibility(isPasswordVisible));
  }
}
