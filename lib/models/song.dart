import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final int id;
  final int artistId;
  final int collectionId;
  final int trackTimeMillis;
  final String artistName;
  final String artworkUrl;
  final String collectionName;
  final String country;
  final String primaryGenreName;
  final String releaseDate;
  final String trackCensoredName;
  final String trackExplicitness;
  final String trackName;
  final String wrapperType;

  Song(
      {this.id,
      this.artistId,
      this.collectionId,
      this.trackTimeMillis,
      this.artistName,
      this.artworkUrl,
      this.collectionName,
      this.country,
      this.primaryGenreName,
      this.releaseDate,
      this.trackCensoredName,
      this.trackExplicitness,
      this.trackName,
      this.wrapperType});

  Song.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        artistId = json['artistId'],
        collectionId = json['collectionId'],
        trackTimeMillis = json['trackTimeMillis'],
        artistName = json['artistName'],
        artworkUrl = json['artworkUrl'],
        collectionName = json['collectionName'],
        country = json['country'],
        primaryGenreName = json['primaryGenreName'],
        releaseDate = json['releaseDate'],
        trackCensoredName = json['trackCensoredName'],
        trackExplicitness = json['trackExplicitness'],
        trackName = json['trackName'],
        wrapperType = json['wrapperType'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'artistId': this.artistId,
        'collectionId': this.collectionId,
        'trackTimeMillis': this.trackTimeMillis,
        'artistName': this.artistName,
        'artworkUrl': this.artworkUrl,
        'collectionName': this.collectionName,
        'country': this.country,
        'primaryGenreName': this.primaryGenreName,
        'releaseDate': this.releaseDate,
        'trackCensoredName': this.trackCensoredName,
        'trackExplicitness': this.trackExplicitness,
        'trackName': this.trackName,
        'wrapperType': this.wrapperType,
      };

  @override
  List<Object> get props => [
        id,
        artistId,
        collectionId,
        trackTimeMillis,
        artistName,
        artworkUrl,
        collectionName,
        country,
        primaryGenreName,
        releaseDate,
        trackCensoredName,
        trackExplicitness,
        trackName,
        wrapperType,
      ];
}
