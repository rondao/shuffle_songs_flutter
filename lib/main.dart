import 'package:flutter/material.dart';

void main() => runApp(ShuffleSongs());

class ShuffleSongs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuffle Songs',
      theme: ThemeData(
        accentColor: Color(0xFF783F4F),
        primaryColor: Color(0xFF452E3E),
        primaryColorDark: Color(0xFF362436),
      ),
      home: SongsList(),
    );
  }
}

class SongsList extends StatefulWidget {
  final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suffle Songs"),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${widget.items[index]}'),
          );
        },
      ),
    );
  }
}
