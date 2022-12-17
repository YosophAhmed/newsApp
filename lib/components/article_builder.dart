import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'article_item.dart';

Widget ArticleBuilder(list, context) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => ArticleItem(list[index], context),
    separatorBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        color: Colors.black,
      ),
    ),
    itemCount: 10,
  ),
  fallback: (context) => Center(child: CircularProgressIndicator()),
);