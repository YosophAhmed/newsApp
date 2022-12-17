import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'article_item.dart';

class ArticleBuilder extends StatelessWidget {
  final List list;

  final BuildContext context;

  const ArticleBuilder({
    Key? key,
    required this.list,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            ArticleItem(article: list[index], context: context),
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Divider(
            color: Colors.black,
          ),
        ),
        itemCount: 10,
      ),
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
