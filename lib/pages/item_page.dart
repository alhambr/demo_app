import 'package:demo_app/models/Cart.dart';
import 'package:demo_app/models/Product.dart';
import 'package:demo_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatelessWidget {

  final String productId;


  const ItemPage({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final data = Provider.of<ProductDataProvider>(context)
      .getElementsById(productId);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title,
          style: GoogleFonts.marmelad(),
        ),
      ),
      body: Container(
        child: Card(
         child: ListView(
           children: <Widget>[
             Hero(
                 tag: data.imgUrl,
                 child: Container(
                   height: 300,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: NetworkImage(data.imgUrl),
                       fit: BoxFit.cover,
                     )
                   ),
                 )
             ),

             Card(
               elevation: 5.0,
               margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
               child: Container(
                 child: Column(
                    children: <Widget>[
                      Text(
                        data.title,
                        style: TextStyle(fontSize: 26,),
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Text('Цена: ', style: TextStyle(fontSize: 24,),),
                          Text('${data.price}', style: TextStyle(fontSize: 24,),)
                        ],
                      ),
                      Divider(),
                      Text(data.description),

                      SizedBox(
                        height: 20,
                      ),

                      Provider.of<CartDataProvider>(context)
                          .cartItems.containsKey(productId)
                      ? Column(
                        children: <Widget>[
                          MaterialButton(
                            color: Color(0xFFCCFF90),
                            child: Text('Перейти в корзину'),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartPage()
                              ));
                            },
                          ),
                          Text(
                            'Товар уже добавлен в корзину',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueGrey
                            ),
                          ),
                        ],
                      )
                      : MaterialButton(
                        color: Theme.of(context).primaryColor,
                        child: Text('Добавить в корзину'),
                        onPressed: () {
                          Provider.of<CartDataProvider>(context, listen: false)
                            .addItem(
                              productId: data.id,
                              price: data.price,
                              title: data.title,
                              imgUrl: data.imgUrl,
                            );
                        },
                      ),



                    ],
                 ),
               ),
             ),
           ],
         ),
        ),
      ),
    );
  }
}
