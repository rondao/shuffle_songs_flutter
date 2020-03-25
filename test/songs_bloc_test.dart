import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shuffle_songs/bloc/songs_list_bloc.dart';
import 'package:shuffle_songs/repository/songs_repository.dart';

import 'assets/songs_list_mock.dart';

class MockSongsRepository extends Mock implements SongsRepository {}

void main() {
  MockSongsRepository mockSongsRepository;

  setUp(() {
    mockSongsRepository = MockSongsRepository();
  });

  group('SongsListEvent.fetchSongs', () {
    test(
      '(Without Bloc Test Library) Emits [SongsListInitial, SongsListLoading, SongsListReady] when successful',
      () {
        when(mockSongsRepository.fetchSongs())
            .thenAnswer((_) async => mockSongsList);

        final bloc = SongsListBloc(mockSongsRepository);
        bloc.add(SongsListEvent.fetchSongs);

        expectLater(
          bloc,
          emitsInOrder([
            SongsListInitial(),
            SongsListLoading(),
            SongsListReady(mockSongsList),
          ]),
        );
      },
    );
  });
}
