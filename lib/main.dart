import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const FlutterApp());

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
            .copyWith(secondary: Colors.black),
      ),
      title: 'Shared Preferences Demo',
      home: const HomePage(title: 'Shared Preferences Demo'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Obtains the shared preferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // Initial counter value
  var _counter = 0;

// Called once and initially when the stfl widget is inserted into the tree.
  @override
  void initState() {
    super.initState();
    // Loading counter value on start
    _loadCounter();
  }

  // Read data
  Future<void> _loadCounter() async {
    // Obtains the shared preferences
    final prefs = await _prefs;
    setState(() {
      // Try reading data from the 'counter' key.
      // If it doesn't exist, returns null.
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

// Increase Counter
  Future<void> _incrementCounter() async {
    // Obtains the shared preferences
    final prefs = await _prefs;
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }

  // Decrease Counter
  Future<void> _decrementCounter() async {
    final prefs = await _prefs;
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) - 1;
      prefs.setInt('counter', _counter);
    });
  }

// Reset Counter
  Future<void> _resetCounter() async {
    final prefs = await _prefs;
    setState(() {
      prefs.remove('counter');
      _counter = (prefs.getInt('counter') ?? 0);
    });
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
            const Text('You have pushed the button this many times'),
            const SizedBox(height: 20),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Decrement',
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: ListTile(
                horizontalTitleGap: 0,
                dense: true,
                leading: Icon(Icons.info),
                title: Text(
                  'Stored value will persist until reset is clicked',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _resetCounter,
              child: const Text('Reset Counter'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
