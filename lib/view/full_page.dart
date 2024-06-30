import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FullPageCrypto extends StatelessWidget {
  String image, name, symbol;
  List<FlSpot> spots;
  num changePercentage, marketCap, athChange;
  double low, high, currentPrice;
  FullPageCrypto(
      {super.key,
      required this.marketCap,
      required this.athChange,
      required this.changePercentage,
      required this.currentPrice,
      required this.high,
      required this.low,
      required this.spots,
      required this.image,
      required this.name,
      required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                    width: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(image))),
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Center(
                child: Text(
                  symbol.toUpperCase(),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: changePercentage.toString().contains('-')
                              ? Colors.red.withAlpha(60)
                              : Colors.green.withAlpha(60),
                          blurRadius: 6.0,
                          spreadRadius: 0.0,
                          offset: const Offset(
                            0.0,
                            3.0,
                          ),
                        ),
                      ],
                    ),
                    child: Text(
                      '${changePercentage.toStringAsFixed(2)}%',
                      style: TextStyle(
                          color: changePercentage.toString().contains('-')
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                  changePercentage.toString().contains('-')
                      ? Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red,
                          size: 30,
                        )
                      : Icon(Icons.arrow_drop_up,
                          size: 30, color: Colors.green),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Center(child: Text('Price in 24h')),
              Container(
                margin: EdgeInsets.all(8),
                height: 300,
                child: LineChart(
                  LineChartData(
                    //borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                          ),
                        ),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget: (value, a) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return Text('Low');
                                    case 1:
                                      return Text('Current');
                                    case 2:
                                      return Text('High');
                                  }
                                  return Text('Empty');
                                }))),
                    //  gridData: FlGridData(show: false),
                    minY: low,
                    maxY: high,
                    minX: 0,
                    maxX: 2,
                    lineBarsData: [
                      LineChartBarData(
                          belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.red.withOpacity(0.3),
                                    Colors.orange.withOpacity(0.3),
                                    Colors.yellow.withOpacity(0.3),
                                    Colors.green.withOpacity(0.3),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.bottomRight)),
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.orange,
                              Colors.yellow,
                              Colors.green,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          barWidth: 5,
                          isCurved: true,
                          spots: spots)
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Price:',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Text(
                    '\$$currentPrice',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Highest Price:',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withAlpha(60),
                          blurRadius: 6.0,
                          spreadRadius: 0.0,
                          offset: const Offset(
                            0.0,
                            3.0,
                          ),
                        )
                      ],
                    ),
                    child: Text(
                      '\$$high',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green),
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lowest Price:',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withAlpha(60),
                          blurRadius: 6.0,
                          spreadRadius: 0.0,
                          offset: const Offset(
                            0.0,
                            3.0,
                          ),
                        )
                      ],
                    ),
                    child: Text(
                      '\$$low',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Market Cap:',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Text(
                    '\$$marketCap',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ath Change:',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  Text(
                    '$athChange',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 2:
      text = const Text('MAR', style: style);
      break;
    case 5:
      text = const Text('JUN', style: style);
      break;
    case 8:
      text = const Text('SEP', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
