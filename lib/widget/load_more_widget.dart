import 'package:flutter/material.dart';
import 'package:flutter_app/common/item_builder.dart';

class LoadMorehWidget<T> extends StatefulWidget {
  final bool isLoading;
  final bool hasMoreData;
  final List<T> dataList;
  final Widget headerWidget;
  final VoidCallback onLoadMore;
  final ItemBuilder buildItem;

  LoadMorehWidget(
      {@required this.isLoading,
      @required this.hasMoreData,
      @required this.headerWidget,
      @required this.dataList,
      @required this.onLoadMore,
      @required this.buildItem});

  @override
  _LoadMorehWidgetState createState() => _LoadMorehWidgetState();
}

class _LoadMorehWidgetState extends State<LoadMorehWidget> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _getMoreData() {
    if (!widget.isLoading && widget.hasMoreData) widget.onLoadMore();
  }

  Widget _loadingItemWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: widget.hasMoreData
          ? _loadingStateWidget()
          : Text("No more data.", style: TextStyle(fontSize: 16.0)),
    );
  }

  Widget _loadingStateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
        SizedBox(width: 16.0),
        Text("Loading...", style: TextStyle(fontSize: 16.0))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.dataList == null ? 0 : widget.dataList.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return widget.headerWidget == null
                ? Container()
                : widget.headerWidget;
          } else if (index == widget.dataList.length + 1) {
            return _loadingItemWidget();
          } else {
            return widget.buildItem(
                context, widget.dataList[index - 1], index - 1);
          }
        },
      ),
    );
  }
}
