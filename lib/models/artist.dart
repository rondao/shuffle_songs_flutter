class Artist {
  int id;
  String artistName;
  String artistType;
  String primaryGenreName;
  String wrapperType;

  Artist(
      {this.id,
      this.artistName,
      this.artistType,
      this.primaryGenreName,
      this.wrapperType});

  Artist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        artistName = json['artistName'],
        artistType = json['artistType'],
        primaryGenreName = json['primaryGenreName'],
        wrapperType = json['wrapperType'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'artistName': this.artistName,
        'artistType': this.artistType,
        'primaryGenreName': this.primaryGenreName,
        'wrapperType': this.wrapperType,
      };
}
