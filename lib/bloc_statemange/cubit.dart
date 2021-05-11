import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc_statemange/states.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/sports_screen.dart';
import 'package:news_app/shared_preference/cache_helper.dart';

class AppNewsCubit extends Cubit<AppNewsStates> {
  AppNewsCubit() : super(AppNewsInitialState());
  static AppNewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List screenTitles = [
    'Business',
    'Sports',
    'Science',
  ];

  void changeScreen(int index) {
    currentIndex = index;

    if (index == 1) getSportsData();

    if (index == 2) getScienceData();

    emit(AppChangeBottomNavBr());
  }

  List<dynamic> business = [];
  void getBusinessData() {
    emit(AppBusinessLoadingState());

    if (business.length == 0) {
      DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '3bf628996fe741479c72fe67abb32c2d',
        },
      ).then((value) {
        print(value.data.toString());

        business = value.data['articles'];
        emit(AppBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppBusinessFailState());
      });
    } else {
      emit(AppBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSportsData() {
    emit(AppSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '3bf628996fe741479c72fe67abb32c2d',
        },
      ).then((value) {
        print(value.data.toString());

        sports = value.data['articles'];
      }).catchError((error) {
        print(error.toString());
        emit(AppSportsFailState());
      });
    } else {
      emit(AppSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScienceData() {
    emit(AppScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '3bf628996fe741479c72fe67abb32c2d',
        },
      ).then((value) {
        print(value.data.toString());

        science = value.data['articles'];
        emit(AppScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppScienceFailState());
      });
    } else {
      emit(AppScienceSuccessState());
    }
  }

  bool isDark = false;
  void changeAppMode({@required bool sharedVal}) {
    if (sharedVal != null) {
      isDark = sharedVal;
      emit(AppThemeModeSuccessState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark)
          .then((value) => emit(AppThemeModeSuccessState()));
    }
  }

  List<dynamic> search = [];
  void getSearchData(String value) {
    emit(AppSearchLoadingState());

    DioHelper.getData(
      url: '/v2/everything',
      query: {
        'q': '$value',
        'apiKey': '3bf628996fe741479c72fe67abb32c2d',
      },
    ).then((value) {
      print(value.data.toString());

      search = value.data['articles'];
      emit(AppSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppScienceFailState());
    });

    // if (search.length == 0) {
    //   DioHelper.getData(
    //     url: '/v2/everything',
    //     query: {
    //       'q': '$value',
    //       'apiKey': '3bf628996fe741479c72fe67abb32c2d',
    //     },
    //   ).then((value) {
    //     print(value.data.toString());
    //
    //     search = value.data['articles'];
    //     emit(AppSearchSuccessState());
    //   }).catchError((error) {
    //     print(error.toString());
    //     emit(AppScienceFailState());
    //   });
    // } else {
    //   emit(AppSearchSuccessState());
    // }
  }
}
