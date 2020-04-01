import 'package:shuffle_songs/models/song.dart';

final songMock = Song(
    trackExplicitness: "notExplicit",
    trackCensoredName: "Praia dos Rumores",
    collectionId: 879273553,
    trackName: "Praia dos Rumores",
    country: "BR",
    primaryGenreName: "Axé",
    artworkUrl:
        "https://firebasestorage.googleapis.com/v0/b/tw-exercicio-mobile.appspot.com/o/albums%2Fbloco-totioque-oxe-perda-nam.png?alt=media&token=83523399-83d2-4fb1-8a20-1d75dbb82568",
    releaseDate: "2008-07-01T08:00:00Z",
    artistId: 358714030,
    trackTimeMillis: 207679,
    collectionName: "Oxe, perda nam!",
    artistName: "Bloco TótiOQue",
    wrapperType: "track",
    id: 779273550);

final songMockJson = """
{
"id":779273550,
"artistId":358714030,
"collectionId":879273553,
"trackTimeMillis":207679,
"artistName":"Bloco TótiOQue",
"artworkUrl":"https://firebasestorage.googleapis.com/v0/b/tw-exercicio-mobile.appspot.com/o/albums%2Fbloco-totioque-oxe-perda-nam.png?alt=media&token=83523399-83d2-4fb1-8a20-1d75dbb82568",
"collectionName":"Oxe, perda nam!",
"country":"BR",
"primaryGenreName":"Axé",
"releaseDate":"2008-07-01T08:00:00Z",
"trackCensoredName":"Praia dos Rumores",
"trackExplicitness":"notExplicit",
"trackName":"Praia dos Rumores",
"wrapperType":"track"
}
""".replaceAll("\n", "");
