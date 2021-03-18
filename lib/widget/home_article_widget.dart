import 'package:flutter/material.dart';
import 'package:flutter_app/data/home_article_bean.dart';
import 'package:flutter_app/utils/common_utils.dart';
import 'package:flutter_html/flutter_html.dart';

import 'circle_ripple_widget.dart';
import 'label_view.dart';

class HomeArticleWidget extends StatelessWidget {
  final HomeArticle article;
  final Function(String, String) onItemClick;
  final Function(String) onShare;
  final Function(HomeArticle) onStar;

  HomeArticleWidget(
      {@required this.article,
      @required this.onItemClick,
      @required this.onShare,
      @required this.onStar});

  Widget _circleTextWidget(BuildContext context, String text) {
    return CircleAvatar(
      radius: 10.0,
      backgroundColor: Theme.of(context).textSelectionColor,
      child: Text(
        text,
        style: TextStyle(fontSize: 12.0, color: Theme.of(context).cardColor),
      ),
    );
  }
  Widget _topView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 30.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 2,
            child:  Row(
              children: <Widget>[
                _circleTextWidget(
                    context,
                    CommonUtils.analysisFirstLetter(
                        article.author, article.shareUser)),
                SizedBox(width: 8.0),
                Container(
                  child: Expanded(
                    child: Text(
                        article.author.isNotEmpty
                            ? article.author
                            : article.shareUser,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 14.0)),
                  )
                )
              ],
            ),
          ),
          Expanded(flex: 1,child: Row(
            children: <Widget>[
              Icon(Icons.timer,
                  size: 18.0, color: Theme.of(context).textSelectionColor),
              SizedBox(width: 4.0),
              Expanded(child: Text(CommonUtils.getYearAndMonthAndDay(article.niceDate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontSize: 14.0)))
            ],
          ))
        ],
      ),
    );
  }

  Widget _chapterWiget(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15.0)),
      child: Text(text,
          style: TextStyle(
              color:Theme.of(context).cardColor, fontSize: 14.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 16.0),
      color: Colors.black12,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onItemClick(article.title, article.link);
          },
          borderRadius: BorderRadius.circular(5.0),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _topView(context),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 10.0, bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text(
                            article.title.trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                              fontSize: 16.0,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: <Widget>[
                                    article.superChapterName.isEmpty
                                        ? SizedBox()
                                        : _chapterWiget(
                                            context, article.superChapterName),
                                    SizedBox(width: 12.0),
                                    article.chapterName.isEmpty
                                        ? SizedBox()
                                        : _chapterWiget(
                                            context, article.chapterName),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  CircleRippleWidget(
                                    icon: Icon(Icons.share,
                                        size: 24.0,
                                        color: Theme.of(context)
                                            .textSelectionColor),
                                    onClick: () {
                                      onShare(article.link);
                                    },
                                  ),
                                  SizedBox(width: 8.0),
                                  CircleRippleWidget(
                                    icon: article.collect
                                        ? Icon(Icons.favorite,
                                            color: Colors.redAccent,
                                            // Theme.of(context).accentColor
                                            size: 24.0)
                                        : Icon(Icons.favorite_border,
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                            size: 24.0),
                                    onClick: () {
                                      onStar(article);
                                    },
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
              Positioned(
                right: 0.0,
                child: article.fresh
                    ? LabelView(
                        Size(35.0, 35.0),
                        labelText: "New",
                        labelAlignment: LabelAlignment.rightTop,
                        labelColor: Theme.of(context).disabledColor,
                        textStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
