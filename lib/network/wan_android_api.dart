import 'dart:io';

import 'package:alice/alice.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_app/data/account_title_bean.dart';
import 'package:flutter_app/data/banner_data.dart';
import 'package:flutter_app/data/base_data.dart';
import 'package:flutter_app/data/home_article_bean.dart';
import 'package:flutter_app/data/hot_search_key_bean.dart';
import 'package:flutter_app/data/login_result.dart';
import 'package:flutter_app/data/navigation_bean.dart';
import 'package:flutter_app/data/project_classify_bean.dart';
import 'package:flutter_app/data/welfare_bean.dart';
import 'package:flutter_app/network/url_constants.dart';
import 'package:path_provider/path_provider.dart';

import '../main.dart';

class WanAndroidApi {
  Dio _dio;
  PersistCookieJar _cookieJar;
  static final WanAndroidApi _instance = WanAndroidApi._internal();

  WanAndroidApi._internal();

  Future<void> init() async {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    _dio.options.contentType = "application/x-www-form-urlencoded";
    Alice alice = Alice(showNotification: false, navigatorKey: navigatorKey);
    _dio.interceptors.add(alice.getDioInterceptor());

    Directory dir = await getTemporaryDirectory();
    String cookPath = dir.path;
    _cookieJar = PersistCookieJar(dir: cookPath + "/.cookies/");
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  factory WanAndroidApi.getInstance() {
    return _instance;
  }

  void clearCookies() {
    _cookieJar?.deleteAll();
  }

  String getLoginUserName() {
    List<Cookie> cookies = loadCookies();
    if (cookies != null && cookies.isNotEmpty) {
      for (int i = 0; i < cookies.length; i++) {
        var cookie = cookies[i];
        if (cookie.name == "loginUserName") {
          return cookie.value;
        }
      }
    }
    return null;
  }

  List<Cookie> loadCookies() {
    Uri uri = Uri.https(
        "www.wanandroid.com", "https://www.wanandroid.com/user/login");
    return _cookieJar.loadForRequest(uri);
  }

  bool isLogin() {
    var cookies = loadCookies();
    return cookies.length > 1;
  }

  Future<LoginResult> login(String account, String password) async {
    print("account: $account, password: $password");
    Response response = await _dio
        .post(loginUrl, data: {"username": account, "password": password});
    print("Request result: ${response.data.toString()}");
    LoginResult result = LoginResult.fromJson(response.data);
    return result;
  }

  Future<LoginResult> register(String account, String password, String confirmPassowrd) async {
    Response response = await _dio
        .post(registerUrl, data: {"username": account, "password": password, "repassword": confirmPassowrd});
    print("Request result: ${response.data.toString()}");
    LoginResult result = LoginResult.fromJson(response.data);
    return result;
  }

  Future<List<BannerData>> getBannerList() async {
    Response response = await _dio.get(bannerUrl);
    BannerBean bean = BannerBean.fromJson(response.data);
    if (bean.errorCode == 0 && bean.data != null && bean.data.isNotEmpty) {
      return bean.data;
    }
    return null;
  }

  Future<HomeArticleBean> getHomeArticles(int page) async {
    Response response = await _dio.get("/article/list/$page/json");
    return HomeArticleBean.fromJson(response.data);
  }

  Future<BaseData> collectArticle(int articleId, bool isCollect) async {
    String url = "";
    if (isCollect) {
      url = "/lg/collect/$articleId/json";
    } else {
      url = "/lg/uncollect_originId/$articleId/json";
    }
    Response response = await _dio.post(url);
    return BaseData.fromJson(response.data);
  }

  Future<ProjectClassifyBean> requestProjectClassify() async {
    Response response = await _dio.get(projectClassifyUrl);
    return ProjectClassifyBean.fromJson(response.data);
  }

  Future<HomeArticleBean> requestProjectData(int page, int classifyId) async {
    String url = "/project/list/$page/json";
    Response response =
        await _dio.get(url, queryParameters: {"cid": classifyId});
    return HomeArticleBean.fromJson(response.data);
  }

  Future<HotSearchKeyBean> requestHotSearchKey() async {
    Response response = await _dio.get(hotSearchUrl);
    return HotSearchKeyBean.fromJson(response.data);
  }

  Future<HomeArticleBean> searchArticles(String keyWord, int page) async {
    String url = "/article/query/$page/json";
    Response response = await _dio.post(url, data: {"k": keyWord});
    return HomeArticleBean.fromJson(response.data);
  }

  Future<WelfareBean> requestWelfareData(int page) async {
    String url = "/data/??????/20/$page";
    Response response = await _dio.get(url,
        options: RequestOptions(baseUrl: "http://gank.io/api"));
    return WelfareBean.fromJson(response.data);
  }

  Future<NavigationBean> requestNavigationData() async {
    Response response = await _dio.get(navigationUrl);
    return NavigationBean.fromJson(response.data);
  }

  Future<AccountTitleBean> requestAccountTitle() async {
    Response response = await _dio.get(accountTitleUrl);
    return AccountTitleBean.fromJson(response.data);
  }

  Future<HomeArticleBean> requestAccountList(int id, int page) async {
    String url = "/wxarticle/list/$id/$page/json";
    Response response = await _dio.get(url);
    return HomeArticleBean.fromJson(response.data);
  }

  Future<HomeArticleBean> requestCollections(int page) async {
    String url = "/lg/collect/list/$page/json";
    Response response = await _dio.get(url);
    return HomeArticleBean.fromJson(response.data);
  }
}
