import 'package:shuffle_songs/models/song.dart';

abstract class SongsRepository {
  Future<List<Song>> fetchSongs();
}
