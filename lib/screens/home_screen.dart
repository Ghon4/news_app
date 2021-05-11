import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc_statemange/cubit.dart';
import 'package:news_app/bloc_statemange/states.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/widgets/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppNewsCubit, AppNewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppNewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                      NavigateTo(context, SearchScreen());
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.brightness_4_outlined,
                    ),
                    onPressed: () {
                      cubit.changeAppMode();
                    }),
              ),
            ],
            title: Text(
              cubit.screenTitles[cubit.currentIndex],
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeScreen(index);
            },
            items: [
              BottomNavigationBarItem(
                label: 'business',
                icon: Icon(
                  Icons.business,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Sports',
                icon: Icon(
                  Icons.sports,
                ),
              ),
              BottomNavigationBarItem(
                label: 'science',
                icon: Icon(
                  Icons.science,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
