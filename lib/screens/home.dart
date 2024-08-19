import 'dart:convert';

import 'package:crypto_app/models/coinModel.dart';
import 'package:crypto_app/screens/components/itemTwo.dart';
import 'package:crypto_app/screens/components/items.dart';
import 'package:crypto_app/src/src.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CoinModel> _coinModel = [];
  var coinMarketList;
  bool isRefreshing = true;

  Future<List<CoinModel>?> getData() async {
    setState(() {
      isRefreshing = true;
    });
    var responce = await http.get(
        Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    setState(() {
      isRefreshing = false;
    });
    // var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      var x = responce.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        _coinModel = coinMarketList;
      });
    } else {
      print(responce.statusCode);
    }
    return null;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: myHeight,
          width: myWidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color.fromARGB(255, 105, 168, 228), c1])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.03, vertical: myHeight * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: myWidth * 0.02,
                            vertical: myHeight * 0.004),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Main Portfolio',
                          style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                              color: black),
                        ),
                      ),
                      Text(
                        'Top 10 Coins',
                        style: TextStyle(fontSize: 16, color: white),
                      ),
                      Text(
                        'Experimental',
                        style: TextStyle(fontSize: 16, color: white),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ 7,644.20',
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          color: white),
                    ),
                    Container(
                      padding: EdgeInsets.all(myWidth * 0.015),
                      height: myHeight * 0.04,
                      width: myWidth * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5)),
                      child: Image.asset(
                        'assets/icons/5.1.png',
                        color: black,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                child: Row(
                  children: [
                    Text(
                      '+162 all time',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: white),
                    ),
                  ],
                ),
              ),
              Container(
                height: myHeight * 0.7,
                width: myWidth,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(
                      height: myHeight * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.08),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Assets',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        child: isRefreshing
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: c1,
                                ),
                              )
                            : coinMarketList == null
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
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Item(
                                        item: _coinModel[index],
                                      );
                                    }),
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                      child: const Row(
                        children: [
                          Text(
                            'Recoment to  Buy',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: myHeight * 0.5,
                        padding: EdgeInsets.only(left: myWidth * 0.03),
                        child: isRefreshing
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: c1,
                                ),
                              )
                            : coinMarketList == null
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
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _coinModel.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width: myWidth * 0.45,
                                        child: ItemTwo(
                                          itemTwo: _coinModel[index],
                                        ),
                                      );
                                    }),
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.001,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
