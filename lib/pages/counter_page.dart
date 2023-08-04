import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CounterProvider.of(context)!.state.value.toString()),
      ),
      body: Column(children: [
        IconButton(
          onPressed: () {
            CounterProvider.of(context)?.state.inc();
          },
          icon: Icon(Icons.remove),
        ),
        Text('0'),
        IconButton(
          onPressed: () {
            CounterProvider.of(context)?.state.dec();
          },
          icon: Icon(Icons.add),
        )
      ]),
    );
  }
}
