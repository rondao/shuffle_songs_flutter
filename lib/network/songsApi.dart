import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shuffle_songs/models/song.dart';
import 'package:shuffle_songs/network/payload.dart';

const _baseUrl = 'https://us-central1-tw-exercicio-mobile.cloudfunctions.net/';
const _lookupEndPoint = 'lookup';

const _defaultLookupParams =
    '?id=909253,1171421960,358714030,1419227,264111789&limit=5';

Future<List<Song>> fetchSongs(http.Client client) async {
  final response =
      await client.get(_baseUrl + _lookupEndPoint + _defaultLookupParams);

  return compute(parseSongs, response.body);
}

List<Song> parseSongs(String responseBody) {
  return PayloadEnvelope.fromJson(jsonDecode(responseBody)).songs;
}
