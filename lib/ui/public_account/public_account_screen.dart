import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/model/public_account_view_model.dart';
import 'package:flutter_app/redux/actions/public_account_action.dart';
import 'package:flutter_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';

import 'account_detail_screen.dart';

class PublicAccountScreen extends StatefulWidget {
  @override
  _PublicAccountScreenState createState() => _PublicAccountScreenState();
}

class _PublicAccountScreenState extends State<PublicAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Public Account",style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,),
      body: StoreConnector<AppState, PublicAccountViewModel>(
        onInit: (store) => store.dispatch(requestAccountTitle()),
        converter: (Store store) => PublicAccountViewModel.fromStore(store),
        builder: (BuildContext context, PublicAccountViewModel viewModel) {
          return DefaultTabController(
            length: viewModel.accountTitles.length,
            child: Column(
              children: <Widget>[
                _buildContent(viewModel),
                _buildAccountTitle(viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(PublicAccountViewModel viewModel) {
    return Expanded(
        child: TabBarView(
            children: viewModel.accountTitles
                .map((title) => AccountDetailScreen(titleId: title.id))
                .toList()));
  }

  Widget _buildAccountTitle(PublicAccountViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.white,
          blurRadius: 0.0,
          spreadRadius: 0.0,
          offset: Offset(1.0, 0.0),
        ),
      ]),
      child: TabBar(
        isScrollable: true,
        labelColor: Colors.green,
        indicatorColor: Colors.red,//选中下划线的颜色
        unselectedLabelColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        tabs: viewModel.accountTitles.map((title) => Text(title.name)).toList(),
      ),
    );
  }
}
