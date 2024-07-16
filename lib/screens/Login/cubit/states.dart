import 'package:shop_app/model/loginModel.dart';

abstract class ShopLoginState {}

class InitialStateShopLogin extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final LoginModel loginModel ;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginErrorState extends ShopLoginState {
final String? error ;


  ShopLoginErrorState(this.error);
}

class ChangeVisibilityOfPassword extends ShopLoginState {}

