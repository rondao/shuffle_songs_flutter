import 'package:bloc_test/bloc_test.dart';
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
      'emits [SongsListInitial, SongsListLoading, SongsListReady] when successful (Without Bloc Test Library)',
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
    blocTest(
      'emits [SongsListLoading, SongsListReady] when successful',
      build: () async {
        when(mockSongsRepository.fetchSongs())
            .thenAnswer((_) async => mockSongsList);
        return SongsListBloc(mockSongsRepository);
      },
      act: (bloc) => bloc.add(SongsListEvent.fetchSongs),
      expect: [
        // SongsListInitial(), - blocTest does not consider the initial state.
        SongsListLoading(),
        SongsListReady(mockSongsList),
      ],
    );
    blocTest(
      'emits [SongsListLoading, SongsListError] when failure',
      build: () async {
        when(mockSongsRepository.fetchSongs())
            .thenThrow(Error());
        return SongsListBloc(mockSongsRepository);
      },
      act: (bloc) => bloc.add(SongsListEvent.fetchSongs),
      expect: [
        SongsListLoading(),
        SongsListError(),
      ],
    );
  });
}
