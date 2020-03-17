import '../models/artist.dart';
import '../models/song.dart';

class PayloadEnvelope {
  int resultCount;
  List<Artist> artists;
  List<Song> songs;

  PayloadEnvelope({this.resultCount, this.artists, this.songs});

  PayloadEnvelope.fromJson(Map<String, dynamic> json) {
    artists = [];
    songs = [];

    resultCount = json['resultCount'];
    if (json['results'] != null) {
      json['results'].forEach((result) {
        switch (result['wrapperType']) {
          case 'artist':
            artists.add(Artist.fromJson(result));
            break;
          case 'track':
            songs.add(Song.fromJson(result));
            break;
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    final results = <Map<String, dynamic>>[];

    data['resultCount'] = this.resultCount;
    if (this.artists != null) {
      results.addAll(this.artists.map((v) => v.toJson()).toList());
    }
    if (this.songs != null) {
      results.addAll(this.artists.map((v) => v.toJson()).toList());
    }
    data['results'] = results;

    return data;
  }
}
