import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/

import 'package:flutter/material.dart';
import 'package:mobiuz/bloc/minute_sms_bloc.dart';
import 'package:mobiuz/model/all.dart';
import 'package:mobiuz/ui/widget/balance_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MinuteSmsPage extends StatefulWidget {
  @override
  _MinuteSmsPageState createState() => _MinuteSmsPageState();
}

class _MinuteSmsPageState extends State<MinuteSmsPage> {
  final bloc = MinuteSmsBloc();

  @override
  void initState() {
    bloc.getMinuteSms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("minute_sms".tr().toUpperCase()),
      ),
      body: StreamBuilder<List<Ism>>(
          stream: bloc.minuteSms,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (snapshot.data[index].catUz != null &&
                              snapshot.data[index].catUz != '')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  context.locale.languageCode == 'ru'
                                      ? snapshot.data[index].catRu
                                      : snapshot.data[index].catUz,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                Divider()
                              ],
                            )
                          else
                            Container(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  bloc.showButtons[index].value =
                                      !bloc.showButtons[index].value;
                                },
                                child: Row(
                                  children: [
                                    Expanded(flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        child: Text(context.locale.languageCode == 'ru'
                                            ? snapshot.data[index].titleRu
                                            : snapshot.data[index].titleUz),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      child: Text(
                                        snapshot.data[index].price,
                                        style: TextStyle(
                                            color: Colors.indigo.shade900),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ValueListenableBuilder(
                                  valueListenable: bloc.showButtons[index],
                                  builder: (ctx, v, w) {
                                    if (v)
                                      return Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                bloc.showButtons[index].value =
                                                    !bloc.showButtons[index]
                                                        .value;
                                              },
                                              child: Container(
                                                child: Text(context.locale
                                                            .languageCode ==
                                                        'ru'
                                                    ? snapshot
                                                        .data[index].descRu
                                                        .replaceAll(
                                                            '<br>', '\n')
                                                    : snapshot
                                                        .data[index].descUz
                                                        .replaceAll(
                                                            '<br>', '\n')),
                                              ),
                                            ),
                                            BalanceButton(
                                              title: "buy".tr().toUpperCase(),
                                              onPressed: () async {
                                                String urlString =
                                                    'tel://${snapshot.data[index].kod}';
                                                if (await canLaunch(
                                                    urlString)) {
                                                  await launch(urlString);
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    else
                                      return Container();
                                  })
                            ],
                          ),
                        ],
                      );
                    }),
              );
            else {
              return Container();
            }
          }),
    );
  }
}
