import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constans/constans.dart';
import 'package:shop_app/cubit/state.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/change_favorite.dart';
import 'package:shop_app/model/get_favortes.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_Points.dart';
import 'package:shop_app/screens/category_screen.dart';
import 'package:shop_app/screens/favorite_screen.dart';
import 'package:shop_app/screens/product_screen.dart';
import 'package:shop_app/screens/setting_screen.dart';

class ShopAppCubit extends Cubit<ShopAppState> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> item = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
  ];

  int currentIndex = 0;

  List<Widget> screen = const [
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen()
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavShopAppState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorite = {};

  void getHomeData() {
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorite.addAll({element.id: element.in_favorites});
      });
      print(favorite);
      emit(ShopAppSuccessHomeState());
    }).catchError((error) {
      emit(ShopAppErrorHomeState());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopAppSuccessCategoriesState());
    }).catchError((error) {
      print("error in category ${error.toString()}");
      emit(ShopAppErrorCategoriesState());
    });
  }

  ChangeFavoriteMode? changeFavoriteMode;

  void changeFavorite(int product_id) {
    favorite[product_id] = !favorite[product_id]! ;
    emit(ShopAppChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITE,
      data: {"product_id": product_id},
      token: token,
    ).then((value) {
      changeFavoriteMode =ChangeFavoriteMode.fromJson(value.data) ;
      if(!changeFavoriteMode!.status)
      {
        favorite[product_id] = !favorite[product_id]! ;
      }else {
        getFavoritesData() ;
      }
      emit(ShopAppSuccessChangeFavoritesState());
    }).catchError((error) {
      favorite[product_id] = !favorite[product_id]! ;
      emit(ShopAppErrorChangeFavoritesState());
    });
  }


  GetFavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopAppLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      favoritesModel = GetFavoritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopAppSuccessGetFavoritesState());
    }).catchError((error) {
      print("error in Get Favorites  ${error.toString()}");
      emit(ShopAppErrorGetFavoritesState());
    });
  }
}
