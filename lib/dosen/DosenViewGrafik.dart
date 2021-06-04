import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:peterpan_app2/model.dart';

import '../model.dart';


class DosenViewGrafik extends StatefulWidget {
  String title;
  final List<charts.Series<Janjian,String>> seriesList;
  final bool animate;
  List<Janjian> myData;


  DosenViewGrafik({Key key, this.title, this.seriesList, this.animate}) : super(key: key);

  @override
  _DosenViewGrafikState createState() => _DosenViewGrafikState(title);
}

class _DosenViewGrafikState extends State<DosenViewGrafik> {
  String title;

  _DosenViewGrafikState(String title);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
