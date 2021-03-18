import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/home_article_bean.dart';
import 'package:flutter_app/model/home_view_model.dart';
import 'package:flutter_app/redux/actions/home_action.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:flutter_app/redux/state/home_state.dart';
import 'package:flutter_app/ui/webview/webview_screen.dart';
import 'package:flutter_app/widget/banner_widget.dart';
import 'package:flutter_app/widget/circle_ripple_widget.dart';
import 'package:flutter_app/widget/home_article_widget.dart';
import 'package:flutter_app/widget/home_refresh_widget.dart';
import 'package:flutter_app/widget/load_empty_widget.dart';
import 'package:flutter_app/widget/load_error_widget.dart';
import 'package:flutter_app/widget/loading_view.dart';
import 'package:flutter_app/widget/loading_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin<HomeScreen> {
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
  }

  AppBar _homeAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("主页",
          style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontFamily: "Source Code Pro",
              fontWeight: FontWeight.bold)),
      actions: <Widget>[
        SizedBox(
          width: 60.0,
          height: 60.0,
          child: CircleRippleWidget(
            icon: Icon(Icons.search, size: 24.0,color: Colors.black,),
            onClick: () {
              // Navigator.push(context, HotSearchPopup());
            },
          ),
        )
      ],
    );
  }

  Widget _buildHomeItem(
      HomeViewModel viewModel, HomeArticle article, int index) {
    return HomeArticleWidget(
      article: article,
      onItemClick: (title, link) => _openWebView(context, title, link),
      onShare: (link) {
        Share.text('Share', link, 'text/plain');
      },
      onStar: (article) {
        viewModel.starArticle(article.id, index, !article.collect);
      },
    );
  }

  Widget _contentWidget(HomeViewModel viewModel) {
    return HomeRefreshWidget<HomeArticle>(
      isLoading: viewModel.isLoading,
      hasMoreData: viewModel.hasMoreData,
      dataList: viewModel.articleList,
      headerWidget: BannerWidget(
          bannerLists: viewModel.bannerList,
          bannerHeight: viewModel.bannerHeight,
          bannerClick: (title, link) => _openWebView(context, title, link)),
      refreshData: () async {
        viewModel.refreshEvents(context, true);
        return Future.delayed(Duration(milliseconds: 1500));
      },
      onLoadMore: () {
        viewModel.refreshEvents(context, false);
      },
      buildItem: (BuildContext context, dynamic data, int index) {
        return data is HomeArticle
            ? _buildHomeItem(viewModel, data, index)
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return StoreConnector<AppState, HomeViewModel>(
        onInit: (store) {
          //初始化的时候获取数据 根据数据显示是加载中还是显示内容
          store.dispatch(LoadStatusAction(status: LoadingStatus.loading));
          store.dispatch(refreshBannerDataAction(context));
          store.dispatch(loadHomeArticleAction(true));
        },
        converter: (store) => HomeViewModel.fromStore(store),
        builder: (context, viewModel) {
          return Scaffold(
            appBar: _homeAppBar(),
            body: LoadingView(
              status: viewModel.status,
              errorContent: LoadErrorWidget(),
              loadingContent: LoadingWidget(),
              emptyContent: LoadEmptyWidget(),
              successContent: _contentWidget(viewModel),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
