import 'package:flutter/material.dart';
import 'package:flutter_app/data/hot_search_key_bean.dart';

@immutable
class SearchActionState {
  final List<HotSearch> hotKeyList;
  final List<String> historyList;

  SearchActionState({@required this.hotKeyList, @required this.historyList});

  factory SearchActionState.initial() {
    return SearchActionState(hotKeyList: [], historyList: []);
  }

  SearchActionState copyWith(
      List<HotSearch> hotKeyList, List<String> historyList) {
    return SearchActionState(
        hotKeyList: hotKeyList ?? this.hotKeyList,
        historyList: historyList ?? this.historyList);
  }
}
