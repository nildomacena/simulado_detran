import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simulado_detran/components/progresso_page/progresso_controller.dart';
import 'package:simulado_detran/components/progresso_page/widgets/analise_categoria_container.dart';
import 'package:simulado_detran/model/resultado_questionario_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressoPage extends StatelessWidget {
  final ProgressoController controller = Get.find();
  ProgressoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build progresso page');
    controller.updateProgresso();
    Widget grafico() => GetX<ProgressoController>(builder: (_) {
          if (_.resultados.isEmpty) return Container();
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: SfCartesianChart(
                title: ChartTitle(text: 'Acertos em %'),
                zoomPanBehavior: ZoomPanBehavior(
                    // Enables pinch zooming
                    enablePanning: true,
                    enablePinching: true),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                    maximum: 100,
                    enableAutoIntervalOnZooming: true,
                    axisLabelFormatter: (AxisLabelRenderDetails label) =>
                        ChartAxisLabel(label.text + '%', const TextStyle())),
                series: <ChartSeries>[
                  // Renders line chart
                  ColumnSeries<ResultadoQuestionario, String>(
                      dataSource: _.resultados,
                      yAxisName: '%',
                      animationDelay: 2,
                      isVisible: true,
                      xValueMapper: (ResultadoQuestionario resultado, __) =>
                          _.resultados.indexOf(resultado).toString(),
                      yValueMapper: (ResultadoQuestionario resultado, __) =>
                          resultado.porcentagemArredondada,
                      dataLabelSettings: const DataLabelSettings(
                        offset: Offset(-5, 0),
                        isVisible: false, /* margin: EdgeInsets.all(10) */
                      ),
                      pointColorMapper:
                          (ResultadoQuestionario resultadoQuestionario, __) =>
                              resultadoQuestionario.porcentagemArredondada < 60
                                  ? Colors.red
                                  : Colors.green,
                      markerSettings: const MarkerSettings(
                          isVisible: true, height: 4, width: 4),
                      animationDuration: 1)
                ]),
          );
        });

    Widget analisePorCategorias = GetBuilder<ProgressoController>(builder: (_) {
      if (_.analiseCategoria == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _.analiseCategoria!.length,
          itemBuilder: ((context, index) =>
              AnaliseCategoriaContainer(_.analiseCategoria![index])));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu progresso'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: [grafico(), analisePorCategorias],
        ),
      ),
    );
  }
}
