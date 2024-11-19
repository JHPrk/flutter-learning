import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_notifier_ex/providers/bg_color.dart';
import 'package:provider_state_notifier_ex/providers/counter.dart';
import 'package:provider_state_notifier_ex/providers/customer_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor, BgColorState>(
            create: (context) => BgColor()),
        StateNotifierProvider<Counter, CounterState>(
            create: (context) => Counter()),
        StateNotifierProvider<CustomerLevel, Level>(
            create: (context) => CustomerLevel()),
      ],
      child: MaterialApp(
        title: 'StateNotifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>();
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();
    return Scaffold(
        backgroundColor: levelState == Level.bronze
            ? Colors.white
            : levelState == Level.silver
                ? Colors.grey
                : Colors.yellow,
        appBar: AppBar(
          backgroundColor: colorState.color,
          title: const Text(
            'StateNotifier',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            '${counterState.counter}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<Counter>().increament();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              width: 10.0,
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<BgColor>().changeColor();
              },
              tooltip: 'ChangeColor',
              child: const Icon(Icons.color_lens_outlined),
            )
          ],
        ));
  }
}
