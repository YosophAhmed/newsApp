import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';

import '../cubit/states.dart';

class HomeLayout extends StatelessWidget {

  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    NewsCubit.get(context).changeTheme();
                    NewsCubit.get(context).getBusiness();
                  },
                  icon: const Icon(
                    Icons.brightness_4_rounded,
                    color: Colors.black,
                    size: 30.0,
                  ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavBarItems,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
