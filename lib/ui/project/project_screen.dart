
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/home_article_bean.dart';
import 'package:flutter_app/model/project_view_model.dart';
import 'package:flutter_app/redux/actions/project_action.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:flutter_app/ui/webview/webview_screen.dart';
import 'package:flutter_app/widget/home_refresh_widget.dart';
import 'package:flutter_app/widget/load_empty_widget.dart';
import 'package:flutter_app/widget/load_error_widget.dart';
import 'package:flutter_app/widget/loading_view.dart';
import 'package:flutter_app/widget/loading_widget.dart';
import 'package:flutter_app/widget/project_appbar.dart';
import 'package:flutter_app/widget/project_item_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with AutomaticKeepAliveClientMixin<ProjectScreen> {
  Text _titleText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAppBar(ProjectViewModel viewModel) {
    if (viewModel.currentClassifyData == null ||
        viewModel.classifyList.isEmpty) {
      return AppBar(title: _titleText("项目"));
    }
    //这个是project的最上面的横向滚动bar，可以选择分类
    return PreferredSize(
        child: ProjectAppBar(
          classifyData: viewModel.currentClassifyData,
          classifyList: viewModel.classifyList,
          onClassifyDataTap: (data) {
            viewModel.onClassifyDataChanged(data);
          },
        ),
        preferredSize: const Size.fromHeight(kToolbarHeight));
  }

  void _openWebView(BuildContext context, String title, String link) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: title,
          initUrl: link,
        ),
      ),
    );
    // String message = title+"--->"+link;
    // Fluttertoast.showToast(msg: message);
  }

  Widget _buildContent(ProjectViewModel viewModel) {
    return HomeRefreshWidget(
        isLoading: viewModel.isLoading,
        hasMoreData: viewModel.hasMoreData,
        headerWidget: null,
        dataList: viewModel.projectList,
        refreshData: () async {
          viewModel.refreshEvents(true);
          return Future.delayed(Duration(milliseconds: 1500));
        },
        onLoadMore: () {
          viewModel.refreshEvents(false);
        },
        buildItem: (BuildContext cotext, dynamic data, int index) {
          return data is HomeArticle
              ? _buildProjectItem(viewModel, data, index)
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, ProjectViewModel>(
        onInit: (store) {
          store.dispatch(requestProjectClassifyAction());
        },
        builder: (context,viewModel){
          return Scaffold(
            appBar: _buildAppBar(viewModel),
            body: LoadingView(
              status:viewModel.status,
              loadingContent: LoadingWidget(),
              emptyContent: LoadEmptyWidget(),
              errorContent: LoadErrorWidget(
                onRetry: () {
                  viewModel.retryEvents();
                },
              ),
              successContent: _buildContent(viewModel),
            ),
          );
        },
        converter: (store)=>ProjectViewModel.fromStore(store));
  }

  Widget _buildProjectItem(
      ProjectViewModel viewModel, HomeArticle article, int index) {
    return ProjectItemWidget(
      article: article,
      onItemClick: (title, link) => _openWebView(context, title, link),
      onStar: (article) {
        viewModel.starArticle(article.id, index, !article.collect);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
