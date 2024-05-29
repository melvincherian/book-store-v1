import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/screens/Home_Screen.dart';

class ScreenUpdate extends StatefulWidget {
  const ScreenUpdate({super.key});

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  late Future<List<SellProductModel>> _sellProductsFuture;

  @override
  void initState() {
    super.initState();
    _sellProductsFuture = _fetchSellProducts();
  }

  Future<List<SellProductModel>> _fetchSellProducts() async {
    final box = await Hive.openBox<SellProductModel>('sell value');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 193, 237),
        title: const Text(
          'Stock Updates',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScreenHome()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Current Stock Information',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<SellProductModel>>(
                future: _sellProductsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No stocks available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              product.product,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              product.quantity < 20
                                  ? 'Out of Stock'
                                  : 'Quantity: ${product.quantity}',
                              style: TextStyle(
                                fontSize: 16,
                                color: product.quantity < 20 ? Colors.red : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
