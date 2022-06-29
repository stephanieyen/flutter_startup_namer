import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { // app is a stateless widget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: const Center( // body property that holds (centered) widget subtree for home screen
          child: RandomWords(),
        ),
      ),
    );
  }
}

// Creates instance of a State class
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

// Generic State class specialized for use with RandomWords
// Maintains state for the RandomWords widget by saving list of generated word pairs
class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final _suggestions = <WordPair>[]; // list of suggested word pairs
    final _biggerFont = const TextStyle(fontSize: 18); // make font size larger

    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);

    // ListView widget to display the suggested word pairs
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),

      // Builder property (itemBuilder) 
      // Called once per suggested word pair to place it into ListTile row
      // Why:        Allows suggested list to continue growing as the user scrolls
      // What:       Factory builder + callback function = anonymous function
      // Parameters: BuildContext (context)
      //             row iterator (i) which increments with each call 
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider(); // visually separate rows

        final index = i ~/ 2; // calculates actual # of pairs (minus dividers)
        
        // If end of list has been reached, then generate 10 more to add
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        // // Create and display a Text widget per word pair
        // return Text(_suggestions[index].asPascalCase);

        // Return each word pair as a ListTile (fixed height row w/ text + icons/widgets)
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase, 
            style: _biggerFont, 
          ),
        );
      }
    );
  }
}