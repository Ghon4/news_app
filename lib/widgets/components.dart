import 'package:flutter/material.dart';
import 'package:news_app/screens/webview_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        NavigateTo(
          context,
          WebViewScreen(article['url']),
        );
      },
      child: ListTile(
        leading: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Transform.translate(
          offset: Offset(-2, -4),
          child: Text(
            '${article['title']}',
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Transform.translate(
          offset: Offset(0, 3),
          child: Text(
            '${article['publishedAt']}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
    );

Widget separateItem() => Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

void NavigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
