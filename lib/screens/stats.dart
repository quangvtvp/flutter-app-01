import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/screens/networkingP2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsWidget extends StatefulWidget {
  const StatsWidget({super.key});

  @override
  State<StatsWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<StatsWidget> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Toan', 9),
      ChartData('Ly', 8.3),
      ChartData('Hoa', 9.5),
    ];

    final List<RateData> rateData = [
      RateData('Đúng', 0.73),
      RateData('Sai', 0.27),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Dashboard 1',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              series: [
                BarSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.subject,
                  yValueMapper: (ChartData data, _) => data.averageScore,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  width: 0.7,
                )
              ],
            ),
            const Text(
              'Dashboard 2',
              style: TextStyle(fontSize: 20),
            ),
            SfCircularChart(
              title: ChartTitle(text: 'Tỉ lệ đúng sai'),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              series: <CircularSeries>[
                PieSeries<RateData, String>(
                  dataSource: rateData,
                  xValueMapper: (RateData data, _) => data.type,
                  yValueMapper: (RateData data, _) => data.rate,
                  dataLabelMapper: (RateData data, _) {
                    return '${data.type} (${(data.rate * 100).toStringAsFixed(0)}%)';
                  },
                  explode: true,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Supabase.instance.client.auth.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                });
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String subject;
  final double averageScore;

  ChartData(this.subject, this.averageScore);
}

class RateData {
  final String type;
  final double rate;

  RateData(this.type, this.rate);
}
