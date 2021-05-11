import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/bloc_statemange/cubit.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/shared_preference/cache_helper.dart';

import 'bloc_statemange/bloc_observer.dart';
import 'bloc_statemange/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppNewsCubit()
          ..getBusinessData()
          ..changeAppMode(sharedVal: isDark),
        child: BlocConsumer<AppNewsCubit, AppNewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  color: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(color: Colors.black),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    unselectedItemColor: Colors.black.withOpacity(.7),
                    elevation: 40.0,
                    backgroundColor: Colors.white),
                textTheme: TextTheme(
                    bodyText2: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
                primarySwatch: Colors.blue,
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey,
                  elevation: 40.0,
                  backgroundColor: HexColor('333739'),
                ),
                textTheme: TextTheme(
                    bodyText2: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
              ),
              themeMode: AppNewsCubit.get(context).isDark
                  ? ThemeMode.light
                  : ThemeMode.dark,
              home: HomeScreen(),
            );
          },
        ));
  }
}
