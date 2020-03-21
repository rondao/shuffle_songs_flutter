import 'package:flutter/material.dart';

import '../../models/song.dart';
import 'songDescription.dart';

class SongTile extends StatelessWidget {
  final Song _song;

  SongTile(this._song);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(_song.artworkUrl)),
      title: SongDescription(_song.trackName, _song.primaryGenreName),
    );
  }
}