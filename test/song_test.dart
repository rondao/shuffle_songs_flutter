import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shuffle_songs/models/song.dart';

import 'assets/song_mock.dart';

void main() {
  group('Song', () {
    test('should encode to Json', () {
      expect(jsonEncode(songMock.toJson()), songMockJson);
    });
    test('should decode from Json', () {
      expect(Song.fromJson(jsonDecode(songMockJson)), songMock);
    });
  });
}
