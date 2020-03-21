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
      title: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: _song.artworkUrl,
            imageBuilder: (context, imageProvider) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CircleAvatar(
                backgroundImage: imageProvider,
                radius: 42,
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.cloud_off),
          ),
          SizedBox(width: 12),
          SongDescription(_song.trackName, _song.primaryGenreName),
        ],
      ),
    );
  }
}
