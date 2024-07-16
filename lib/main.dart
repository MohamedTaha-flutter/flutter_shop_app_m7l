import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constans/constans.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/state.dart';
import 'package:shop_app/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/Login/loginScreen.dart';
import 'package:shop_app/screens/On_Bording_Screen.dart';
import 'package:shop_app/screens/shopHomeScreen/shop_home_screen.dart';
import 'package:shop_app/styles/theme.dart';


main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.getDAta(key: "OnBoarding");
  token = CacheHelper.getDAta(key: "token");
  print(token) ;

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopHomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(RunApp(startScreen: widget,));
}

class RunApp extends StatelessWidget {
  const RunApp({super.key, required this.startScreen,});

  final Widget startScreen;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ShopAppCubit()
        ..getHomeData()..getCategoryData()..getFavoritesData(),
      child: BlocConsumer<ShopAppCubit, ShopAppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            home: startScreen,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
          );
        },
      ),
    );
  }
}
