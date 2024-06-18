import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderList>(context, listen: false).loadOrders().then((_) {
      setState(() {
        isLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(
          order: orders.items[i],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
