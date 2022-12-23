import 'package:call_api_flutter/api/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProduct;

  final Services _services = Services();

  @override
  void initState() {
    super.initState();

    futureProduct = _services.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Products"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                futureProduct = _services.fetchProduct();
              });
            },
            child: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title:
                              Text("[${snapshot.data?[index].id}] ${snapshot.data?[index].title}" ?? "ไม่พบชื่อ"),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: LineChart(
                    LineChartData(lineBarsData: [
                      LineChartBarData(
                          spots: List.generate(snapshot.data?.length ?? 0,
                              (index) {
                        return FlSpot(index.toDouble(),
                            snapshot.data![index].price.toDouble());
                      }))
                    ]),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
