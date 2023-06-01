  String convertEmbed(String link) {
    var videoId = link.split('v=')[1];
    var embedLink = 'https://www.youtube.com/embed/$videoId';
    return embedLink;
  }

  String convertEmbedfromGoogle(String link) {
  var fileId = link.split('/d/')[1].split('/')[0];
  var embedLink = 'https://drive.google.com/file/d/$fileId/preview';
  return embedLink;
}