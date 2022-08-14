import 'package:demo_app/models/Cart.dart';
import 'package:demo_app/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return Container(
      width: 150,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(int.parse(product.color)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // @Todo  Навигация на страницу продукта
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(product.imgUrl),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
                Container(
                  child: Text(
                    '${product.title}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    '${product.price}'
                ),
                IconButton(
                    onPressed: () {
                      Provider.of<CartDataProvider>(context, listen: false)
                      .addItem(
                        productId: product.id,
                        price: product.price,
                        title: product.title,
                        imgUrl: product.imgUrl,
                      );
                    },
                    icon: Icon(Icons.add_circle_outline, color: Colors.black12,)
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
