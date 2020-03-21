import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/song.dart';

class SongTile extends StatelessWidget {
  final Song _song;

  SongTile(this._song);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          SongArtwork(_song.artworkUrl),
          SizedBox(width: 12),
          SongDescription(_song.trackName, _song.primaryGenreName),
        ],
      ),
    );
  }
}

class SongArtwork extends StatelessWidget {
  final String _artworkUrl;

  SongArtwork(this._artworkUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 84,
      child: CachedNetworkImage(
        imageUrl: _artworkUrl,
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
    );
  }
}

class SongDescription extends StatelessWidget {
  final String _description;
  final String _title;

  SongDescription(this._title, this._description);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _title,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(height: 5),
        Text(
          _description,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
