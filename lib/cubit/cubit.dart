import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/settings_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(IntialNewsState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getsports();
    if (index == 2) getScience();
    emit(BottomNavBarState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List business = [];

  void getBusiness() {
    emit(GetBusinessNewsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'e9f56a587c424dec9b3c2fe29c3cfa8e',
      },
    ).then((value) {
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessNewsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessNewsErrorsState(error.toString()));
    });
  }

  List sports = [];

  void getsports() {
    emit(GetSportsNewsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'e9f56a587c424dec9b3c2fe29c3cfa8e',
        },
      ).then((value) {
        sports = value?.data['articles'];
        print(sports[0]['title']);
        emit(GetSportsNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsNewsErrorsState(error.toString()));
      });
    } else {
      emit(GetSportsNewsSuccessState());
    }
  }

  List science = [];

  void getScience() {
    emit(GetScienceNewsLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'e9f56a587c424dec9b3c2fe29c3cfa8e',
        },
      ).then((value) {
        science = value?.data['articles'];
        print(science[0]['title']);
        emit(GetScienceNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetScienceNewsErrorsState(error.toString()));
      });
    } else {
      emit(GetScienceNewsSuccessState());
    }
  }

  bool isDark = false;

  void changeTheme({bool? shared}) {
    if (shared != null){
      isDark = shared;
      emit(ChangeAppTheme());
    }
    else{
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark)
        .then((value) => emit(ChangeAppTheme()));
    }

  }
}
