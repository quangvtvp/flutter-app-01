import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

main() {
  runApp(const MaterialApp(
    home: FusionChart(),
  ));
}

class FusionChart extends StatefulWidget {
  const FusionChart({super.key});

  @override
  State<FusionChart> createState() => _FusionChartState();
}

class _FusionChartState extends State<FusionChart> {
  Future<ChartData> mockDataFromServer() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 4));
    // Sample data
    // Sample data
    final List<RateData> rateData = [
      RateData('Đúng', 54),
      RateData('Sai', 27),
    ];

    final List<SubjectAverage> subjectAverage = [
      SubjectAverage('Toan', 9.0),
      SubjectAverage('Ly', 8.3),
      SubjectAverage('Hoa', 9.5),
      SubjectAverage('Van', 8.0),
    ];

    final List<FlashCardStats> flashCardStats = [
      FlashCardStats(item: 'Quiz đã làm', count: 8),
      FlashCardStats(item: 'Word đã học', count: 40),
    ];
    return ChartData(rateData, subjectAverage, flashCardStats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fusion Chart'),
      ),
      body: Center(
        child: FutureBuilder<ChartData>(
          future: mockDataFromServer(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Fusion Chart dashboard 1'),
                  SfCircularChart(
                    title: const ChartTitle(text: 'Tỉ lệ trả lời đúng'),
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.right,
                    ),
                    series: [
                      PieSeries<RateData, String>(
                        dataSource: snapshot.data?.rateData ?? [],
                        xValueMapper: (RateData data, _) => data.name,
                        yValueMapper: (RateData data, _) => data.count,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      )
                    ],
                  ),
                  const Text('Fusion Chart dashboard 2'),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    series: [
                      BarSeries<SubjectAverage, String>(
                        dataSource: snapshot.data?.subjectAverage ?? [],
                        xValueMapper: (SubjectAverage data, _) => data.subject,
                        yValueMapper: (SubjectAverage data, _) =>
                            data.averageScore,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      )
                    ],
                  ),
                  const Text('Fusion Chart dashboard 3'),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    series: [
                      BarSeries<FlashCardStats, String>(
                        dataSource: snapshot.data?.flashCardStats ?? [],
                        xValueMapper: (FlashCardStats data, _) => data.item,
                        yValueMapper: (FlashCardStats data, _) => data.count,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                        width: 0.4,
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChartData {
  // include RateData, SubjectAverage, FlashCardStats
  final List<RateData> rateData;
  final List<SubjectAverage> subjectAverage;
  final List<FlashCardStats> flashCardStats;

  ChartData(this.rateData, this.subjectAverage, this.flashCardStats);
}

class RateData {
  final String name;
  final double count;

  RateData(this.name, this.count);
}
// correct answers 54, incorrect answers 20

class SubjectAverage {
  final String subject;
  final double averageScore;

  SubjectAverage(this.subject, this.averageScore);
}

// eg Vat ly 8.1, Toan 9.0, Hoa 8.5, Tieng Anh 8.0
class FlashCardStats {
  final String item;
  final double count;

  FlashCardStats({required this.item, required this.count});
}
