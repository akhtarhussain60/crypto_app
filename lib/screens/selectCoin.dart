import 'dart:convert';

import 'package:crypto_app/models/chartModel.dart';
import 'package:crypto_app/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class SelectCoin extends StatefulWidget {
  var selectItem;

  SelectCoin({super.key, this.selectItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: myWidth * 0.05, vertical: myHeight * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          height: myHeight * 0.07,
                          child: Image.network(widget.selectItem.image)),
                      SizedBox(
                        width: myWidth * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectItem.id,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: myHeight * 0.01),
                          Text(
                            widget.selectItem.symbol,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.selectItem.currentPrice}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      SizedBox(height: myHeight * 0.01),
                      Text(
                        '${widget.selectItem.marketCapChangePercentage24H}%',
                        style: TextStyle(
                            fontSize: 16,
                            color: widget.selectItem
                                        .marketCapChangePercentage24H >=
                                    0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Low',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: myHeight * 0.005),
                          Text(
                            '\$${widget.selectItem.low24H}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'High',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: myHeight * 0.005),
                          Text(
                            '\$${widget.selectItem.high24H}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Volume',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          SizedBox(height: myHeight * 0.005),
                          Text(
                            '\$${widget.selectItem.totalVolume}M',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: myHeight * 0.01),
                SizedBox(
                  height: myHeight * 0.37,
                  width: myWidth,
                  child: isRefresh == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: c1,
                          ),
                        )
                      : itemChart == null
                          ? Padding(
                              padding: EdgeInsets.all(myHeight * 0.06),
                              child: const Center(
                                child: Text(
                                  'Attention this Api is free,'
                                  'so you cannot send multiple'
                                  'requests per second, please'
                                  'wait and try again later.',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          : SfCartesianChart(
                              trackballBehavior: trackballBehavior,
                              zoomPanBehavior: ZoomPanBehavior(
                                  enablePanning: true, zoomMode: ZoomMode.x),
                              series: <CandleSeries>[
                                CandleSeries<ChartModel, int>(
                                  enableSolidCandles: true,
                                  enableTooltip: true,
                                  bullColor: Colors.green,
                                  bearColor: Colors.red,
                                  dataSource: itemChart,
                                  xValueMapper: (ChartModel sales, _) =>
                                      sales.time,
                                  lowValueMapper: (ChartModel sales, _) =>
                                      sales.low,
                                  highValueMapper: (ChartModel sales, _) =>
                                      sales.high,
                                  openValueMapper: (ChartModel sales, _) =>
                                      sales.open,
                                  closeValueMapper: (ChartModel sales, _) =>
                                      sales.close,
                                  animationDuration: 55,
                                )
                              ],
                            ),
                ),
                SizedBox(
                  height: myHeight * 0.01,
                ),
                Center(
                  child: SizedBox(
                    height: myHeight * 0.04,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: text.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: myWidth * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  textBool = [
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                  textBool[index] = true;
                                });
                                setDays(text[index]);
                                getChart();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: myWidth * 0.03,
                                    vertical: myHeight * 0.006),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: textBool[index] == true
                                        ? c1.withOpacity(0.5)
                                        : Colors.transparent),
                                child: Text(
                                  text[index],
                                  style: TextStyle(fontSize: 16, color: black),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: myHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                  child: const Text(
                    'News',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: myWidth * 0.06,
                          vertical: myHeight * 0.01),
                      child: ListView(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing '
                                  'elit, sed do eiusmod tempor incididunt ut labore et '
                                  'dolore magna aliqua. Ut enim ad minim veniam, quis '
                                  'nostrud exercitation ullamco laboris nisi ut aliquip'
                                  'ex ea commodo consequat. Duis aute irure dolor in '
                                  'reprehenderit in voluptate velit esse cillum dolore'
                                  'eu fugiat nulla pariatur. Excepteur sint occaecat '
                                  'cupidatat non proident, sunt in culpa qui officia '
                                  'deserunt mollit anim id est laborum.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                width: myWidth * 0.04,
                              ),
                              SizedBox(
                                width: myWidth * 0.25,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: myHeight * 0.04,
                                  backgroundImage:
                                      const AssetImage('assets/images/11.PNG'),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                )
              ],
            )),
            SizedBox(
              height: myHeight * 0.1,
              width: myWidth,
              child: Column(
                children: [
                  const Divider(),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Row(
                    children: [
                      SizedBox(width: myWidth * 0.07),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: myHeight * 0.012),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: c1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: myHeight * 0.025,
                                color: white,
                              ),
                              SizedBox(
                                width: myWidth * 0.01,
                              ),
                              Text(
                                'Add to Porfolio',
                                style: TextStyle(fontSize: 20, color: white),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: myWidth * 0.05),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: myHeight * 0.012),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.withOpacity(0.2)),
                          child: Image.asset(
                            'assets/icons/3.1.png',
                            height: myHeight * 0.03,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: myWidth * 0.05),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [true, false, false, false, false, false];

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'w') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;
  bool isRefresh = true;

  Future<void> getChart() async {
    String url =
        '${'https://api.coingecko.com/api/v3/coins/' + widget.selectItem.id}/ohlc?vs_currency=usd&days=$days';

    setState(() {
      isRefresh = true;
    });
    var respoce = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    setState(() {
      isRefresh = false;
    });
    if (respoce.statusCode == 200) {
      Iterable x = json.decode(respoce.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(respoce.statusCode);
    }
  }
}
