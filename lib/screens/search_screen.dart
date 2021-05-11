import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc_statemange/cubit.dart';
import 'package:news_app/bloc_statemange/states.dart';
import 'package:news_app/widgets/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<AppNewsCubit, AppNewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = AppNewsCubit.get(context).search;
        bool isSearch = true;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 18.0),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: defaultFormField(
                      onChange: (value) {
                        AppNewsCubit.get(context).getSearchData(value);
                      },
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Search can not be empty';
                        }
                      },
                      label: 'Search',
                      prefix: Icons.search),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 500,
                  child: ConditionalBuilder(
                    condition: list.length > 0,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildArticleItem(list[index], context),
                        separatorBuilder: (context, index) => separateItem(),
                        itemCount: list.length),
                    fallback: (context) => isSearch
                        ? Container()
                        : Center(child: CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
