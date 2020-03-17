import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  final String _description;
  final String _title;

  SongTile(this._title, this._description);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // TODO: Change from Icon to CircleAvatar.
      leading: Icon(
        Icons.account_circle,
        color: Colors.white70,
        size: 48,
      ),
      title: SongDescription(_title, _description),
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

class SongsListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      thickness: 0.3,
    );
  }
}
