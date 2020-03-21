import 'package:flutter/material.dart';

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
