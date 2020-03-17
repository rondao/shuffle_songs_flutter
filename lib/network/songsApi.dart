import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'payload.dart';
import '../models/song.dart';

const baseUrl = 'https://us-central1-tw-exercicio-mobile.cloudfunctions.net/';
const lookupEndPoint = 'lookup';

const defaultLookupParams =
    '?id=909253,1171421960,358714030,1419227,264111789&limit=5';

Future<List<Song>> fetchSongs(http.Client client) async {
  final response =
      await client.get(baseUrl + lookupEndPoint + defaultLookupParams);

  return compute(parseSongs, response.body);
}

List<Song> parseSongs(String responseBody) {
  return PayloadEnvelope.fromJson(jsonDecode(responseBody)).songs;
}
