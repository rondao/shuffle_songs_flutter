import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/song.dart';
import 'songDescription.dart';

class SongTile extends StatelessWidget {
  final Song _song;

  SongTile(this._song);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: _song.artworkUrl,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.cloud_off),
      ),
      title: SongDescription(_song.trackName, _song.primaryGenreName),
    );
  }
}
