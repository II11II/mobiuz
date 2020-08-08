/*
    @Authour: Islomkuja Akhrorov
    Created at: 7/13/20
*/
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiuz/bloc/home_bloc.dart';
import 'package:mobiuz/ui/page/balance_page.dart';
import 'package:mobiuz/ui/page/internet_page.dart';
import 'package:mobiuz/ui/page/minute_sms_page.dart';
import 'package:mobiuz/ui/page/news_page.dart';
import 'package:mobiuz/ui/page/rate_page.dart';
import 'package:mobiuz/ui/page/service_page.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    bloc.getData().then((value) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value.tr()),
        duration: Duration(milliseconds: 700),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer(),
        bottomNavigationBar: bottomNavigationBar(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('mobiuz'.tr()),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'mobiuz'.tr(),
                  style: TextStyle(fontSize: 16),
                )),
            Expanded(
             
              child: GridView(
                  padding: EdgeInsets.all(30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      BalancePage())),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Image.asset(
                              'assets/icon/balans.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text('balance'.tr().toUpperCase())
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      InternetPage())),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Image.asset('assets/icon/internet.png'),
                          ),
                        ),
                        Text('internet'.tr().toUpperCase())
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => RatePage())),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Image.asset('assets/icon/tarifi.png'),
                          ),
                        ),
                        Text('rates'.tr().toUpperCase())
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      ServicePage())),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Image.asset('assets/icon/uslugi.png'),
                          ),
                        ),
                        Text('services'.tr().toUpperCase())
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      MinuteSmsPage())),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Image.asset('assets/icon/minuti.png'),
                          ),
                        ),
                        Text('minute_sms'.tr().toUpperCase())
                      ],
                    ),
                    Column(
                      children: [
                        FlatButton(
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      NewsPage())),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 3,
                            child: Image.asset('assets/icon/news.png'),
                          ),
                        ),
                        Text('news'.tr().toUpperCase())
                      ],
                    ),
                  ]),
            ),
          ],
        ));
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.call),
            title: Text('call_center'.tr().toUpperCase())),
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text('home'.tr().toUpperCase())),
        BottomNavigationBarItem(
          icon: Icon(Icons.sim_card),
          title: Text('cabinet'.tr().toUpperCase()),
        ),
      ],
      currentIndex: 1,
      onTap: (index) async {
        if (index == 0) {
          String codeNumber = 'tel://+998971300909';
          if (await canLaunch(codeNumber)) {
            launch(codeNumber);
          }
        }
        if (index == 2) {
          String urlString = "https://ip.mobi.uz/selfcare";
          if (await canLaunch(urlString)) launch(urlString);
        }
      },
      selectedItemColor: Theme.of(context).primaryColor,
    );
  }

  drawer() {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16),
            child: Text(
              "more".tr(),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('russian'.tr()),
            onTap: () {
              context.locale = Locale('ru', 'RU');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('uzbek'.tr()),
            onTap: () {
              context.locale = Locale('uz', 'UZ');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('share'.tr()),
            onTap: () {
              if (Platform.isIOS)
                Share.share(''); // TODO : APP Store link
              else {
                Share.share('');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.send),
            title: Text('telegram_channel'.tr()),
            onTap: () async {
              String telegram = 'https://t.me/umsnew';
              if (await canLaunch(telegram)) {
                launch(telegram);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('rate_app'.tr()),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
