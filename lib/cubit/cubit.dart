import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/settings_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(IntialNewsState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems = const [
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
    emit(
      BottomNavBarState(),
    );
  }

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List business = [];

  void getBusiness() async {
    if (business.isEmpty) {
      emit(
        GetBusinessNewsLoadingState(),
      );
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'e9f56a587c424dec9b3c2fe29c3cfa8e',
        },
      ).then((value) {
        business = value.data['articles'];
        emit(
          GetBusinessNewsSuccessState(),
        );
      }).catchError((error) {
        emit(
          GetBusinessNewsErrorsState(
            error.toString(),
          ),
        );
      });
    } else {
      emit(
        GetBusinessNewsSuccessState(),
      );
    }
  }

  List sports = [];

  void getsports() async {
    emit(GetSportsNewsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'e9f56a587c424dec9b3c2fe29c3cfa8e',
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(GetSportsNewsSuccessState());
      }).catchError((error) {
        emit(
          GetSportsNewsErrorsState(
            error.toString(),
          ),
        );
      });
    } else {
      emit(
        GetSportsNewsSuccessState(),
      );
    }
  }

  List science = [];

  void getScience() async {
    emit(GetScienceNewsLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'e9f56a587c424dec9b3c2fe29c3cfa8e',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(GetScienceNewsSuccessState());
      }).catchError((error) {
        emit(
          GetScienceNewsErrorsState(
            error.toString(),
          ),
        );
      });
    } else {
      emit(GetScienceNewsSuccessState());
    }
  }


}
