import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  final String description;
  final String title;

  SongTile(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // TODO: Change from Icon to CircleAvatar.
      leading: Icon(
        Icons.account_circle,
        color: Colors.white70,
        size: 48,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 5),
          Text(
            this.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
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
