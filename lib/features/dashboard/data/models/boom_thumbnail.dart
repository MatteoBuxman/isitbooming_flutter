//Represents the data required to show the user their 'My Booms' grid.
class BoomThumbnail {
  int index;
  Uri thumbnailLink;

  //The link used to fetch all the required boom data for the boom it represents. This is done when the user clicks
  //on the boom.
  Uri furtherInformation;

  BoomThumbnail(
      this.index, this.thumbnailLink, this.furtherInformation);

  factory BoomThumbnail.fromJson(Map<String, dynamic> json) {
    return BoomThumbnail(
        json['id'], Uri.parse(json['thumbnailLink']), Uri.parse(json['furtherInformation']));
  }
}
