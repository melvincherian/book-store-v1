import 'package:flutter/material.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/home.dart';

class SellDetails extends StatefulWidget {
  const SellDetails({Key? key}) : super(key: key);

  @override
  State<SellDetails> createState() => _SellDetailsState();
}

class _SellDetailsState extends State<SellDetails> {
  @override

void initState() {
  saveSellProduct();
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenHome()),
                    );
                  },
                ),
                const SizedBox(width: 88),
                const Text(
                  'Sell Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<SellProductModel>>(
              valueListenable: sell, // Assuming sell is a ValueNotifier containing the list of sell products
              builder: (context, sellProducts, _) {
                if (sellProducts.isNotEmpty) {
                  return ListView.builder(
                    itemCount: sellProducts.length,
                    itemBuilder: (context, index) {
                      final sellProduct = sellProducts[index];
                      return ListTile(
                        title: Text('Name: ${sellProduct.name}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone Number: ${sellProduct.phonenumber}'),
                            Text('Product: ${sellProduct.product}'),
                            Text('Discount: ${sellProduct.discount}'),
                            Text('Price: \$${sellProduct.price.toString()}'),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No sell details available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
