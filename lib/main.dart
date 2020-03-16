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
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
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
      body: ListView.separated(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            // TODO: Change from Icon to CircleAvatar.
            leading: Icon(
              Icons.account_circle,
              color: Colors.white70,
              size: 48,
            ),
            title: Text(
              '${widget.items[index]}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            thickness: 0.3,
          );
        },
      ),
    );
  }
}
