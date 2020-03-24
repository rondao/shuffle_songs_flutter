import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shuffle_songs/models/song.dart';
import 'package:shuffle_songs/network/payload.dart';
import 'package:shuffle_songs/repository/songs_repository.dart';

class SongsNetworkRepository implements SongsRepository {
  static const _baseUrl =
      'https://us-central1-tw-exercicio-mobile.cloudfunctions.net/';
  static const _lookupEndPoint = 'lookup';

  static const _defaultLookupParams =
      '?id=909253,1171421960,358714030,1419227,264111789&limit=5';

  @override
  Future<List<Song>> fetchSongs() async {
    final response =
        await http.get(_baseUrl + _lookupEndPoint + _defaultLookupParams);

    return compute(parseSongs, response.body);
  }

  static List<Song> parseSongs(String responseBody) {
    return PayloadEnvelope.fromJson(jsonDecode(responseBody)).songs;
  }
}
