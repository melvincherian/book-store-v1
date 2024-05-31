// ignore_for_file: unused_import, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:hive/hive.dart';
import 'package:project_week8/functions/db_functions.dart';

ValueNotifier<List<SellProductModel>> sell = ValueNotifier([]);

Future<void> addSellproduct(SellProductModel value) async {
  final sellDB = await Hive.openBox<SellProductModel>('sell value');
  await sellDB.add(value);
  sell.value.add(value);
  sell.notifyListeners();
}

Future<void> saveSellProduct() async {
  final sellDB = await Hive.openBox<SellProductModel>('sell value');
  sell.value.clear();
  sell.value.addAll(sellDB.values);
  sell.notifyListeners();
}

Future<void> deleteSellProduct(int id) async {
  final sellDB = await Hive.openBox<SellProductModel>('sell value');
  sellDB.delete(id);
  sell.value.removeWhere((element) => element.id == id);
  sell.notifyListeners();
}

class ScreenProfit extends StatefulWidget {
  const ScreenProfit({super.key, required SellProductModel});

  @override
  State<ScreenProfit> createState() => _ScreenProfitState();
}

class _ScreenProfitState extends State<ScreenProfit> {
  String _selectedPeriod = 'Last 7 Days';
  List<FlSpot> lineData = [];

  @override
  void initState() {
    super.initState();
    _updateLineData();
    _loadData();
  }

  Future<void> _loadData() async {
    await Hive.openBox<SellProductModel>('sell value');
    await saveSellProduct();
  }

  void _updateLineData() {
    setState(() {
      if (_selectedPeriod == 'Last 7 Days') {
        lineData = [
          const FlSpot(0, 1),
          const FlSpot(1, 2),
          const FlSpot(2, 1.5),
          const FlSpot(3, 3),
        ];
      } else if (_selectedPeriod == 'Last 30 Days') {
        lineData = [
          const FlSpot(0, 1),
          const FlSpot(1, 1.5),
          const FlSpot(2, 1.2),
          const FlSpot(3, 2.5),
          const FlSpot(4, 3),
          const FlSpot(5, 2.8),
          const FlSpot(6, 3.5),
        ];
      } else if (_selectedPeriod == 'All Sales') {
        lineData = [
          const FlSpot(0, 1),
          const FlSpot(1, 2),
          const FlSpot(2, 1.5),
          const FlSpot(3, 3),
          const FlSpot(4, 2.5),
          const FlSpot(5, 3.2),
          const FlSpot(6, 3.8),
          const FlSpot(7, 4),
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: sell,
        builder: (context, List<SellProductModel> sellProducts, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Title section
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.black,
                        ),
                        const SizedBox(width: 60),
                        const Text(
                          'Profit Details',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Line Chart section or No Data Message
                  SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: sellProducts.isNotEmpty
                        ? LineChart(
                            LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots: lineData,
                                  isCurved: true,
                                  barWidth: 4,
                                  belowBarData: BarAreaData(
                                    show: true,
                                  ),
                                  dotData: const FlDotData(
                                    show: true,
                                  ),
                                ),
                              ],
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                getDrawingHorizontalLine: (value) {
                                  return const FlLine(
                                    color: Colors.grey,
                                    strokeWidth: 0.5,
                                  );
                                },
                                getDrawingVerticalLine: (value) {
                                  return const FlLine(
                                    color: Colors.grey,
                                    strokeWidth: 0.5,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 22,
                                    getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return const Text('Jan', style: TextStyle(color: Colors.black));
                                        case 1:
                                          return const Text('Feb', style: TextStyle(color: Colors.black));
                                        case 2:
                                          return const Text('Mar', style: TextStyle(color: Colors.black));
                                        case 3:
                                          return const Text('Apr', style: TextStyle(color: Colors.black));
                                        default:
                                          return const Text('', style: TextStyle(color: Colors.black));
                                      }
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 28,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      return Text('${value.toInt()}k', style: const TextStyle(color: Colors.black));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        :const Center(
                            child: Text(
                              'No sales data available',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                  // Dropdown menu
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: DropdownButton<String>(
                      value: _selectedPeriod,
                      items: <String>['Last 7 Days', 'Last 30 Days', 'All Sales'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPeriod = newValue!;
                          _updateLineData();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 90),
                      Text(
                        'Recent Sales',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Recent sales data
                  sellProducts.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sellProducts.length,
                          itemBuilder: (context, index) {
                            final product = sellProducts[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.product,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$${product.price}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      :const Center(
                          child: Text(
                            'No sales data available',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
