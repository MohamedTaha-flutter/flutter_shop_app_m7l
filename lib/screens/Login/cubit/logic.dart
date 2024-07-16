import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/loginModel.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/Login/cubit/states.dart';

import '../../../network/remote/end_Points.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {

  ShopLoginCubit() : super(InitialStateShopLogin());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel ;

  void userPostLoginData ({
    required String email ,
    required String password ,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url:login ,
        data: {
          "email" :  email,
          "password" :  password,
        }
    ).then((value)
    {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message);
      print(loginModel!.status);
      print(loginModel!.data.token);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error)
    {
    print(error.toString()) ;
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool visibility = true ;
  void changeVisibilityOfPassword()
  {
    visibility = !visibility ;
    emit(ChangeVisibilityOfPassword());
  }
}
