import 'package:crypto_app/screens/selectCoin.dart';
import 'package:flutter/material.dart';

class ItemTwo extends StatelessWidget {
  var itemTwo;
  ItemTwo({super.key, this.itemTwo});

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.03, vertical: myHeight * 0.02),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectCoin(
                        selectItem: itemTwo,
                      )));
        },
        child: Container(
          padding: EdgeInsets.only(
              left: myWidth * 0.02,
              right: myWidth * 0.01,
              top: myHeight * 0.02,
              bottom: myHeight * 0.02),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: const Offset(0, 2))
              ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: myHeight * 0.04, child: Image.network(itemTwo.image)),
              SizedBox(
                height: myHeight * 0.02,
              ),
              Text(
                itemTwo.id,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: myHeight * 0.02,
              ),
              Row(
                children: [
                  Text(
                    itemTwo.priceChange24H.toString().contains('')
                        ? '-\$ ${itemTwo.priceChange24H.toStringAsFixed(2).toString().replaceAll('_', '')}'
                        : '\$ ' + itemTwo.priceChange24H.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: myWidth * 0.03,
                  ),
                  Text(
                    '${'\$' + itemTwo.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                        color: itemTwo.marketCapChangePercentage24H >= 0
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
