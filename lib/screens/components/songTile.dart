import 'package:flutter/material.dart';

import 'songDescription.dart';

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