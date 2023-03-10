import 'package:flutter/material.dart';
import 'classifier.dart';

void main() {
  runApp(const TextClassifierApp());
}

class TextClassifierApp extends StatefulWidget {
  const TextClassifierApp({super.key});

  @override
  State<TextClassifierApp> createState() => _TextClassifierAppState();
}

class _TextClassifierAppState extends State<TextClassifierApp> {
  final TextEditingController _controller = TextEditingController();
  final Classifier _classifier = Classifier();
  String review = "";
  List<double> predictions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Review Analyzer'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Type a movie review',
                ),
                controller: _controller,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  child: const Text('Analyse'),
                  onPressed: () {
                    setState(() {
                      review = _controller.text;
                      predictions = _classifier.classify(review);
                    });
                    _controller.clear();
                  }),
              const SizedBox(height: 20),
              if (predictions.length == 2)
                Card(
                  color: predictions[1] > predictions[0]
                      ? Colors.lightGreen
                      : Colors.red,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          leading: const Icon(Icons.question_answer_outlined),
                          title: Text(
                            'Review: $review',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          subtitle: Text(
                            'Positive: ${predictions[1].toStringAsFixed(4)}\nNegative: ${predictions[0].toStringAsFixed(4)}',
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          )),
                    ],
                  ),
                )
              else
                Container()
            ],
          ),
        ),
      ),
    );
  }
}
