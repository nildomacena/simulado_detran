import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/home_page/home_controller.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.find();

  HomePage({Key? key}) : super(key: key);

  Widget grafico() => GetX<HomeController>(builder: (_) {
        if (_.resultados.isEmpty) return Container();
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: SfCartesianChart(
              title: ChartTitle(text: 'Acertos em %'),
              zoomPanBehavior: ZoomPanBehavior(
                  // Enables pinch zooming
                  enablePinching: true),
              primaryXAxis: NumericAxis(
                decimalPlaces: 1,
              ),
              primaryYAxis: NumericAxis(
                  maximum: 100,
                  enableAutoIntervalOnZooming: true,
                  axisLabelFormatter: (AxisLabelRenderDetails label) =>
                      ChartAxisLabel(label.text + '%', TextStyle())),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<ResultadoQuestionario, num>(
                    dataSource: _.resultados,
                    yAxisName: '%',
                    xValueMapper: (ResultadoQuestionario resultado, __) =>
                        _.resultados.indexOf(resultado),
                    yValueMapper: (ResultadoQuestionario resultado, __) =>
                        resultado.porcentagemArredondada,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    markerSettings: const MarkerSettings(isVisible: true),
                    animationDuration: 1)
              ]),
        );
      });

  Widget graficobkp() => GetX<HomeController>(builder: (_) {
        if (_.resultados.isEmpty) return Container();
        print('GetX resultados: ${_.resultados.length}');

        // List<chart.Series<ResultadoQuestionario, num>> seriesList = [];
        List<chart.Series<ResultadoQuestionario, String>> seriesList = [];
        seriesList.add(chart.Series<ResultadoQuestionario, String>(
          data: _.resultados,
          id: 'resultados',
          displayName: 'Teste',
          domainFormatterFn: (ResultadoQuestionario resultado, __) =>
              (teste) => 'asdfas',
          insideLabelStyleAccessorFn: (ResultadoQuestionario resultado, __) =>
              const chart.TextStyleSpec(fontSize: 18),
          labelAccessorFn: (ResultadoQuestionario resultado, __) => '%',
          domainUpperBoundFn: (ResultadoQuestionario resultado, __) => '100',
          domainFn: (ResultadoQuestionario resultado, __) =>
              _.resultados.indexOf(resultado).toString(),
          measureFn: (ResultadoQuestionario resultado, __) =>
              resultado.totalAcertos / resultado.totalQuestoes * 100,
        ));
        /* seriesList.add(chart.Series(
          measureFormatterFn: (ResultadoQuestionario resultado, number) =>
              ((number) => '%'),
          displayName: 'Seu progresso',
          data: _.resultados,
          id: 'asdfass',
          measureUpperBoundFn: (ResultadoQuestionario resultado, number) => 100,
          measureFn: (ResultadoQuestionario resultado, number) =>
              resultado.totalAcertos / resultado.totalQuestoes * 100,
          domainFn: (ResultadoQuestionario resultado, number) =>
              _.resultados.indexOf(resultado),
        )); */
        /* 
        seriesList.add(chart.Series(
            data: _.resultados,
            id: 'asdfass',
            measureFn: (resultado, number) {
              print('Resultado: $resultado - $number');
            },
            domainFn: (resultado, number) {
              print('Resultado: $resultado - $number');
              return 1;
            }));
        */
        return Container(
          margin: const EdgeInsets.all(20),
          child: chart.BarChart(
            seriesList,
            animate: true,
            defaultRenderer: chart.BarRendererConfig(),
          ),
        );
        /* return chart.LineChart(seriesList,
            // animate: animate,
            defaultRenderer: chart.LineRendererConfig(includePoints: true)); */
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 250, width: Get.width, child: grafico()),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: Get.width,
                height: 100,
                child: ElevatedButton(
                  child: const Text(
                    'FAZER SIMULADO TRADICIONAL',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  /*  style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width * .5, 50)), */
                  onPressed: () {
                    controller.irParaSimulado();
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: Get.width,
                height: 100,
                child: ElevatedButton(
                  child: const Text(
                    'RESPONDER QUESTÕES AVULSAS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  /*  style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width * .5, 50)), */
                  onPressed: () {
                    controller.irParaAvulso();
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: Get.width,
                height: 100,
                child: ElevatedButton(
                  child: const Text(
                    'VER HISTÓRICO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  /*  style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width * .5, 50)), */
                  onPressed: () {},
                ),
              ),
            ],
          ),
          /*  Positioned(
              bottom: 10,
              child: ElevatedButton(
                child: const Text('Iniciar Questionário'),
                /*  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width * .5, 50)), */
                onPressed: () {
                  controller.irParaSimulado();
                },
              )) */
        ],
      ),
    );
  }
}
