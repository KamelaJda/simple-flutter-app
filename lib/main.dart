import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'routes/shops.dart';
import 'utils/databaseutils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseUtils.configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const MyHomePage(title: 'Lista zakupów'),
      darkTheme: ThemeData(brightness: Brightness.dark,),
      themeMode: ThemeMode.dark,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _changeRoute(BuildContext buildContext, int id) {
    Navigator.push(
      buildContext,
      MaterialPageRoute(builder: (context) {
        switch (id) {
          case 1: return const ShopsList();
          case 2: return const ShopsList(); // TODO
          default: NullThrownError();
        }
        return const ShopsList();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have clicked the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            // const Text(
            //   'Gówno',
            // ),
            Card(
              elevation: 0,
              child: InkWell(
                child: const SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(child: Text('Twoje sklepy')),
                ),
                onTap: () {
                  _changeRoute(context, 1);
                },
              )
            ),

            Card(
              elevation: 0,
              child: InkWell(
                child: const SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(child: Text('Twoje zakupy')),
                ),
                onTap: () {
                  _changeRoute(context, 2);
                },
              )
            ),

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
