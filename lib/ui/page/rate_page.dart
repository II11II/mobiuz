import 'dart:io';

/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiuz/bloc/rate_bloc.dart';
import 'package:mobiuz/model/all.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class RatePage extends StatefulWidget {
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final bloc = RateBloc();

  @override
  void initState() {
    bloc.getRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text('rates'.tr()),
        ),
        body: StreamBuilder(
          stream: bloc.rates,
          builder:
              (BuildContext context, AsyncSnapshot<List<Tarifs>> snapshot) {
            if (snapshot.hasData)
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 10,
                    child: PageView.builder(
                        onPageChanged: (index) {
                          bloc.circleColor.value = index;
                        },
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      snapshot.data[index].photo != "" &&
                                              snapshot.data[index].photo != null
                                          ? Image.asset(
                                              "assets/icon/${snapshot.data[index].photo}.png")
                                          : Container(),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 8, left: 8),
                                        child: Text(
                                          context.locale.languageCode == 'ru'
                                              ? snapshot.data[index].titleRu
                                              : snapshot.data[index].titleUz,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: WebViewPlus(
                                      javascriptMode: JavascriptMode.disabled,
                                      debuggingEnabled: false,
                                 
                                      onWebViewCreated: (c) {
                                        String html;
                                        if (context.locale.languageCode ==
                                            'ru') {
                                          html = snapshot.data[index].descrRu
                                              .replaceAll('ic_sms.png',
                                                  'https://i.ibb.co/gZB1fzB/ic-sms.png')
                                              .replaceAll('ic_phone.png',
                                                  'https://i.ibb.co/c279b5g/ic-phone.png')
                                              .replaceAll('ic_chart.png',
                                                  'https://i.ibb.co/ZNbmwsK/ic-chart.png')
                                              .replaceAll('ic_gift.png',
                                                  'https://i.ibb.co/HVWYFHD/ic-gift.png');
                                        } else {
                                          html = snapshot.data[index].descrUz
                                              .replaceAll('ic_phone.png',
                                                  'https://i.ibb.co/c279b5g/ic-phone.png')
                                              .replaceAll('ic_sms.png',
                                                  'https://i.ibb.co/gZB1fzB/ic-sms.png')
                                              .replaceAll('ic_chart.png',
                                                  'https://i.ibb.co/ZNbmwsK/ic-chart.png')
                                              .replaceAll('ic_gift.png',
                                                  'https://i.ibb.co/HVWYFHD/ic-gift.png');
                                        }
                                        if (Platform.isIOS){
                                          html += """<style>body {zoom: 3; 
                                          -moz-transform: scale(3); 
                                          -moz-transform-origin: 0 0;}</style>""";}
                                        c.loadString(html);
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      String codeNumber =
                                          'tel://${snapshot.data[index].kod}';
                                      if (await canLaunch(codeNumber)) {
                                        launch(codeNumber);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        color: Colors.green,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Text(
                                            "go_over".tr().toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                            valueListenable: bloc.circleColor,
                            builder:
                                (BuildContext context, value, Widget child) {
                              if (value == index)
                                return Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              else
                                return Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                            });
                      },
                    ),
                  )
                ],
              );
            else {
              return Container();
            }
          },
        ));
  }
}
