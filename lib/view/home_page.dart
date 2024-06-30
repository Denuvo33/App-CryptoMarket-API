import 'package:crypto_api/model/crypto_model.dart';
import 'package:crypto_api/provider/providers.dart';
import 'package:crypto_api/view/full_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  List<double> interpolateValues(double low, double high, int numPoints) {
    List<double> values = [];
    double step = (high - low) / (numPoints - 1);
    for (int i = 0; i < numPoints; i++) {
      values.add(low + (step * i));
    }
    return values;
  }

  List<FlSpot> _generateInterpolatedSpots(
      double low, double high, int numPoints) {
    List<FlSpot> spots = [];
    List<double> prices = interpolateValues(low, high, numPoints);

    for (int i = 0; i < numPoints; i++) {
      spots.add(FlSpot(i.toDouble(), prices[i]));
    }

    return spots;
  }

  @override
  Widget build(BuildContext context, ref) {
    final _data = ref.watch(cryptoDataprovider);

    final String searchTerm = ref.watch(searchTermProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Syahid',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Trendings',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  _data.when(
                      data: (_data) {
                        List<CryptoModel> cryptoList = _data
                            .where((element) =>
                                element.name!.toLowerCase().contains(''))
                            .toList();

                        return SizedBox(
                          height: 250,
                          child: AnimationLimiter(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                var crypto = cryptoList[index];
                                List<FlSpot> spots = [
                                  FlSpot(0, cryptoList[index].low!.toDouble()),
                                  FlSpot(
                                      1,
                                      cryptoList[index]
                                          .currentPrice!
                                          .toDouble()),
                                  FlSpot(2, cryptoList[index].high!.toDouble()),
                                ];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(seconds: 1),
                                  child: SlideAnimation(
                                    horizontalOffset: 150,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (contex) =>
                                                      FullPageCrypto(
                                                        marketCap:
                                                            crypto.marketCap!,
                                                        athChange: crypto
                                                            .athChangePercentage!,
                                                        changePercentage: crypto
                                                            .changePercentage!,
                                                        spots: spots,
                                                        image: crypto.image!,
                                                        name: crypto.name!,
                                                        symbol: crypto.symbol!,
                                                        low: crypto.low!
                                                            .toDouble(),
                                                        high: crypto.high!
                                                            .toDouble(),
                                                        currentPrice: crypto
                                                            .currentPrice!
                                                            .toDouble(),
                                                      )));
                                        },
                                        child: Card(
                                          child: Container(
                                            width: 200,
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      cryptoList[index].name!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: cryptoList[
                                                                        index]
                                                                    .changePercentage
                                                                    .toString()
                                                                    .contains(
                                                                        '-')
                                                                ? Colors.red
                                                                    .withAlpha(
                                                                        60)
                                                                : Colors.green
                                                                    .withAlpha(
                                                                        60),
                                                            blurRadius: 6.0,
                                                            spreadRadius: 0.0,
                                                            offset:
                                                                const Offset(
                                                              0.0,
                                                              3.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        '${cryptoList[index].changePercentage!.toStringAsFixed(2)}%',
                                                        style: TextStyle(
                                                            color: cryptoList[
                                                                        index]
                                                                    .changePercentage
                                                                    .toString()
                                                                    .contains(
                                                                        '-')
                                                                ? Colors.red
                                                                : Colors.green),
                                                      ),
                                                    ),
                                                    cryptoList[index]
                                                            .changePercentage
                                                            .toString()
                                                            .contains('-')
                                                        ? Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.red,
                                                            size: 30,
                                                          )
                                                        : Icon(
                                                            Icons.arrow_drop_up,
                                                            size: 30,
                                                            color: Colors.green,
                                                          ),
                                                  ],
                                                ),
                                                Text(
                                                  cryptoList[index]
                                                      .symbol!
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  height: 100,
                                                  child: LineChart(
                                                    curve: Curves.linear,
                                                    duration: Duration(
                                                        milliseconds: 150),
                                                    LineChartData(
                                                      borderData: FlBorderData(
                                                          show: false),
                                                      titlesData: FlTitlesData(
                                                          show: false),
                                                      gridData: FlGridData(
                                                          show: false),
                                                      minY: cryptoList[index]
                                                          .low!
                                                          .toDouble(),
                                                      maxY: cryptoList[index]
                                                          .high!
                                                          .toDouble(),
                                                      minX: 0,
                                                      maxX: 2,
                                                      lineBarsData: [
                                                        LineChartBarData(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Colors.red,
                                                                Colors.orange,
                                                                Colors.yellow,
                                                                Colors.green,
                                                              ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                            ),
                                                            barWidth: 5,
                                                            isCurved: true,
                                                            spots: spots)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 40,
                                                      child: ClipRRect(
                                                        child: Image.network(
                                                            cryptoList[index]
                                                                .image!),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          'USD',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                            '\$${cryptoList[index].currentPrice}'),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      error: (e, error) {
                        return Center(
                          child: Text(error.toString()),
                        );
                      },
                      loading: () => const Center(
                            child: CircularProgressIndicator(),
                          )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Market',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _data.when(data: (_data) {
                    List<CryptoModel> cryptoList = _data
                        .where((element) => element.name!
                            .toLowerCase()
                            .contains(searchTerm.toLowerCase()))
                        .toList();
                    return AnimationLimiter(
                      child: Expanded(
                        child: RefreshIndicator(
                          onRefresh: () {
                            return ref.refresh(cryptoDataprovider.future);
                          },
                          child: ListView.builder(
                            itemCount: cryptoList.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<FlSpot> spots = [
                                FlSpot(0, cryptoList[index].low!.toDouble()),
                                FlSpot(1,
                                    cryptoList[index].currentPrice!.toDouble()),
                                FlSpot(2, cryptoList[index].high!.toDouble()),
                              ];
                              var crypto = cryptoList[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: Duration(seconds: 1),
                                child: SlideAnimation(
                                  verticalOffset: 150,
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contex) =>
                                                    FullPageCrypto(
                                                      athChange: crypto
                                                          .athChangePercentage!,
                                                      spots: spots,
                                                      marketCap:
                                                          crypto.marketCap!,
                                                      image: crypto.image!,
                                                      name: crypto.name!,
                                                      changePercentage: crypto
                                                          .changePercentage!,
                                                      symbol: crypto.symbol!,
                                                      low: crypto.low!
                                                          .toDouble(),
                                                      high: crypto.high!
                                                          .toDouble(),
                                                      currentPrice: crypto
                                                          .currentPrice!
                                                          .toDouble(),
                                                    )));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 50,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        crypto.image!,
                                                        fit: BoxFit.cover,
                                                      ))),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      crypto.name!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      crypto.symbol!
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      '\$ ${crypto.currentPrice}'),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: crypto
                                                                      .changePercentage
                                                                      .toString()
                                                                      .contains(
                                                                          '-')
                                                                  ? Colors.red
                                                                      .withAlpha(
                                                                          60)
                                                                  : Colors.green
                                                                      .withAlpha(
                                                                          60),
                                                              blurRadius: 6.0,
                                                              spreadRadius: 0.0,
                                                              offset:
                                                                  const Offset(
                                                                0.0,
                                                                3.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          '${crypto.changePercentage!.toStringAsFixed(2)}%',
                                                          style: TextStyle(
                                                              color: crypto
                                                                      .changePercentage
                                                                      .toString()
                                                                      .contains(
                                                                          '-')
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                      crypto.changePercentage
                                                              .toString()
                                                              .contains('-')
                                                          ? Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: Colors.red,
                                                              size: 30,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .arrow_drop_up,
                                                              size: 30,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }, error: (object, e) {
                    return Center(
                      child: Text(e.toString()),
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
