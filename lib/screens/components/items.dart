import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;
  Item({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
      child: Expanded(
        flex: 1,
        child: Container(
          child: Row(
            children: [
              SizedBox(
                  height: myHeight * 0.05, child: Image.network(item.image)),
              SizedBox(
                width: myWidth * 0.01,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.id,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '0.4' + item.symbol,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: myHeight * 0.05,
                  // width: myWidth * 0.2,
                  child: Sparkline(
                    data: item.sparklineIn7D.price,
                    lineWidth: 2,
                    lineColor: item.marketCapChangePercentage24H >= 0
                        ? Colors.green
                        : Colors.red,
                    fillMode: FillMode.below,
                    fillGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.7],
                        colors: item.marketCapChangePercentage24H >= 0
                            ? [Colors.green, Colors.green.shade100]
                            : [Colors.red, Colors.red.shade100]),
                  ),
                ),
              ),
              SizedBox(
                width: myWidth * 0.03,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.priceChange24H.toString().contains('')
                          ? '-\$ ${item.priceChange24H.toStringAsFixed(2).toString().replaceAll('_', '')}'
                          : '\$ ' + item.priceChange24H.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: myWidth * 0.03,
                    ),
                    // Text(
                    //   item.priceChange24H.toStringAsFixed(2),
                    //   style: const TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.normal,
                    //       color: Colors.grey),
                    // ),
                    Text(
                      '${'\$' + item.marketCapChangePercentage24H.toStringAsFixed(1)}%',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: item.marketCapChangePercentage24H >= 0
                              ? Colors.green
                              : Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
