import 'package:flutter/material.dart';
import 'package:flutter_app/data/home_article_bean.dart';
import 'package:flutter_app/redux/state/home_state.dart';

@immutable
class SearchResultSate {
  final String queryText;
  final int currentPage;
  final bool isLoading;
  final bool hasMoreData;
  final int articleResult;
  final LoadingStatus status;
  final List<HomeArticle> articleList;

  SearchResultSate(
      {@required this.queryText,
      @required this.currentPage,
      @required this.isLoading,
      @required this.hasMoreData,
      @required this.articleResult,
      @required this.status,
      @required this.articleList});

  factory SearchResultSate.initial() {
    return SearchResultSate(
        queryText: "",
        currentPage: 0,
        isLoading: false,
        hasMoreData: true,
        articleResult: 0,
        status: LoadingStatus.idle,
        articleList: []);
  }

  SearchResultSate copyWith(
      String queryText,
      int currentPage,
      bool isLoading,
      bool hasMoreData,
      int articleResult,
      LoadingStatus status,
      List<HomeArticle> articleList) {
    return SearchResultSate(
        queryText: queryText ?? this.queryText,
        currentPage: currentPage ?? this.currentPage,
        isLoading: isLoading ?? this.isLoading,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        articleResult: articleResult ?? this.articleResult,
        status: status ?? this.status,
        articleList: articleList ?? this.articleList);
  }
}
