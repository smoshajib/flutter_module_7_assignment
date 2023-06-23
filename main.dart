import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  int quantity;

  Product(this.name, this.price, {this.quantity = 0});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product('Product 1', 10.0),
    Product('Product 2', 20.0),
    Product('Product 3', 30.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Quantity: ${products[index].quantity}'),
                RaisedButton(
                  child: Text('Buy Now'),
                  onPressed: () {
                    setState(() {
                      products[index].quantity++;
                      if (products[index].quantity == 5) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Congratulations!'),
                              content: Text(
                                'You\'ve bought 5 ${products[index].name}!',
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(products)),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage(this.products);

  @override
  Widget build(BuildContext context) {
    int totalQuantity = products.fold(0, (sum, product) => sum + product.quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text(
          'Total Products: $totalQuantity',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
