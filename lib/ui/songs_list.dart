import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuffle_songs/bloc/songs_list_bloc.dart';

import 'package:shuffle_songs/ui/components/song_tile.dart';

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<SongsListBloc>(context).add(SongsListEvent.fetchSongs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shuffle Songs"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () => BlocProvider.of<SongsListBloc>(context)
                .add(SongsListEvent.shuffleSongs),
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: BlocBuilder<SongsListBloc, SongsListState>(
        builder: (context, state) {
          if (state is SongsListLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SongsListLoaded) {
            return ListView.separated(
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                return SongTile(state.songs[index]);
              },
              separatorBuilder: (context, index) {
                return SongsListDivider();
              },
            );
          } else {
            return Center(
                child: Icon(
              Icons.cloud_off,
              color: Colors.white70,
              size: 128,
            ));
          }
        },
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
