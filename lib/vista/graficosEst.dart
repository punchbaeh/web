import 'package:flutter/material.dart';
import 'package:flutter_application_intraner/modelo/NPChartBar.dart';
import 'package:flutter_application_intraner/modelo/NotasContinuas.dart';
import 'package:flutter_application_intraner/modelo/NotasParciales.dart';
import 'package:flutter_application_intraner/vista/secundarioEst.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyGraficos extends StatefulWidget{
  const MyGraficos({super.key});

  @override
  State<MyGraficos> createState() => _MyGraficosState();

}

class _MyGraficosState extends State<MyGraficos>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255,1,161,197),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>MySecondApp()));
        }, icon: Icon(Icons.keyboard_return, color: Colors.white,),),
        title: Text('Universidad Católica Sedes Sapientae', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Parciales'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        ColumnSeries<Dato, String>(
                        dataSource: NotasParciales.sesionParciales!.parciales(),
                        xValueMapper: (Dato nota, _) => nota.x,
                        yValueMapper: (Dato nota, _) => nota.y,
                        name: 'Notas',
                        color: Colors.cyan[200],
                        dataLabelSettings: DataLabelSettings(isVisible: true),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: Column(
                  children: [
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Notas Continuas'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        ColumnSeries<NotasContinuas, String>(
                        dataSource: NotasContinuas.sesionContinuas!,
                        xValueMapper: (NotasContinuas nota, _) => nota.numero.toString(),
                        yValueMapper: (NotasContinuas nota, _) => nota.nota,
                        name: 'Notas',
                        color: Colors.amber,
                        dataLabelSettings: DataLabelSettings(isVisible: true),),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}