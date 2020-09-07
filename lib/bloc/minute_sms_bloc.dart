import 'package:flutter/cupertino.dart';
import 'package:mobiuz/bloc/base/base_bloc.dart';
/**
    @Author: Islomkhuja Akhrorov
    Created at:
 **/
import 'package:mobiuz/model/all.dart';
import 'package:rxdart/rxdart.dart';

class MinuteSmsBloc extends BaseBloc {
  final _all = PublishSubject<List>();
  final _minuteSms = PublishSubject<List<Ism>>();

  Stream<List> get all => _all.stream;

  Stream<List> get minuteSms => _minuteSms.stream;
  
  List<ValueNotifier> showButtons;

  Future getMinuteSms() async {
    List<Ism> minuteSms = await repo.getMinuteSms;

    _minuteSms.sink.add(minuteSms);

    showButtons =
        List.generate(minuteSms.length, (index) => ValueNotifier<bool>(false));
  }

  @override
  void dispose() {
    _minuteSms.close();
  }
}
