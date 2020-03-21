import 'package:flutter/material.dart';

import '../../models/song.dart';
import 'songDescription.dart';

class SongTile extends StatelessWidget {
  final Song _song;

  SongTile(this._song);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // TODO: Change from Icon to CircleAvatar.
      leading: Image.network(_song.artworkUrl),
      title: SongDescription(_song.trackName, _song.primaryGenreName),
    );
  }
}