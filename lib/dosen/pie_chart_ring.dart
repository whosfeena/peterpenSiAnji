import 'package:flutter/material.dart';
import 'package:peterpan_app2/model.dart';
//import 'package:flutter_charts/flutter_charts.dart';
import 'package:pie_chart/pie_chart.dart';

import '../apiservices.dart';


class piechart  extends StatefulWidget{
  String title;
  String nidn;
  piechart({Key key, this.title, this.nidn}) : super(key: key);

  @override
  _piechartState createState() => _piechartState(title,nidn);

}


class _piechartState extends State<piechart>{
  // ignore: deprecated_member_use
  String nidn;
  List<Janjian> modelUser = new List();

  String title;

  _piechartState(this.title, this.nidn);


  @override
  Widget build(BuildContext context) {
    double Menunggu = 0;
    double Disetujui = 0;
    double Ditolak = 0;
    double Dibatalkan = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: apiservices().GetAllJanjian(nidn),
          builder:
              (BuildContext context, AsyncSnapshot<List<Janjian>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              modelUser = snapshot.data;
              for (var model in modelUser)
              {
                if (model.sttsJanjian == "DISETUJUI") {

                  Disetujui  = Disetujui + 1;
                }
                else if (model.sttsJanjian == "DITOLAK")
                {
                  Ditolak  = Ditolak + 1;
                }
                else if (model.sttsJanjian == "MENUNGGU")
                {
                  Menunggu  = Menunggu + 1;
                }
                else if (model.sttsJanjian == "DIBATALKAN")
                {
                  Dibatalkan  = Dibatalkan + 1;
                }
              }

              return SingleChildScrollView(
                child: 
                PieChart(
                  dataMap: {"Disetujui":Disetujui,"Ditolak":Ditolak,"Menunggu":Menunggu,"Dibatalkan":Dibatalkan},
                  chartRadius: 300,
                  chartType: ChartType.ring,
                  //centerText: "pie chart",
                  colorList: [Colors.red,Colors.green,Colors.grey[500],Colors.orange],
                  chartValuesOptions: ChartValuesOptions(
                      chartValueStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,color: Colors.black
                      ),
                      showChartValueBackground: false,
                      //showChartValues: true,
                     // showChartValuesOutside: true
                  ),
                  legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      legendPosition: LegendPosition.right,
                      showLegends: true
                  ),
                  animationDuration: Duration(milliseconds: 2000),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }
}