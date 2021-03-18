import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/datas.dart';
import 'package:flutter_app/network/wan_android_api.dart';
import 'package:flutter_app/ui/home/home_screen.dart';
import 'package:flutter_app/ui/main_screen.dart';
import 'package:flutter_app/widget/countdown_widget.dart';

import '../loginAndRegister/login_screen.dart';

class SplashScreen extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          constraints: BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imageList[Random().nextInt(12)],
              ),
              fit: BoxFit.cover
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 20.0,
                bottom: 30.0,
                child: CountdownWidget(
                  onCountDownTap: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        List<Cookie> cookieList =
                        WanAndroidApi.getInstance().loadCookies();
                        if (cookieList == null || cookieList.length < 2) {
                          return LoginScreen();
                        } else {
                          return MainScreen();
                        }
                      }),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
  }
}