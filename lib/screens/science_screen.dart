import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc_statemange/cubit.dart';
import 'package:news_app/bloc_statemange/states.dart';
import 'package:news_app/widgets/components.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppNewsCubit, AppNewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = AppNewsCubit.get(context).science;
        return ConditionalBuilder(
          condition: list.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) => separateItem(),
              itemCount: 5),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
