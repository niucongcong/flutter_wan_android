import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_app/data/home_article_bean.dart';
import 'package:html/dom.dart' as dom;

import 'circle_ripple_widget.dart';

class CollectionResultItem extends StatelessWidget {
  final HomeArticle article;
  final Function(HomeArticle) itemClick;
  final Function(HomeArticle) onCollect;

  const CollectionResultItem(
      {Key key, @required this.article, this.itemClick, this.onCollect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          color: Colors.grey,
          width: 1
        ),top: BorderSide(
            color: Colors.grey,
            width: 1
        )),
      ),
      child: InkWell(
        onTap: () {
          itemClick(article);
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        _titleWidget(context),
                        SizedBox(height: 8.0),
                        _contentWiget(),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  _buildCollectWidget()
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.white12,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCollectWidget() {
    return CircleRippleWidget(
      onClick: () {
        onCollect(article);
      },
      icon: Icon(Icons.favorite, color: Colors.redAccent, size: 24.0),
    );
  }

  Widget _titleWidget(BuildContext context) {
    return Html(
      data: article.title,
      defaultTextStyle: TextStyle(
          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "em":
              return baseStyle.merge(TextStyle(
                  color: Theme.of(context).accentColor,
                  fontStyle: FontStyle.normal));
          }
        }
        return baseStyle;
      },
    );
  }

  Widget _contentWiget() {
    return Row(
      children: <Widget>[
        (article.author != null && article.author.isNotEmpty)
            ? Row(children: <Widget>[
                Icon(Icons.account_circle, size: 16.0, color: Colors.black),
                SizedBox(width: 4.0),
                Text(article.author,
                    style: TextStyle(fontSize: 14.0, color: Colors.black)),
                SizedBox(width: 16.0),
              ])
            : Container(),
        Icon(Icons.access_time, size: 16.0, color: Colors.black),
        SizedBox(width: 4.0),
        Text(article.niceDate,
            style: TextStyle(fontSize: 14.0, color: Colors.black))
      ],
    );
  }
}
