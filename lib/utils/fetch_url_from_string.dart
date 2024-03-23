String getUrlFromString({String? content}) {
  if (content != null) {
    RegExp exp = new RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    RegExpMatch? match = exp.firstMatch(content!);
    return match != null ? content.substring(match.start, match.end) : '';
  }
  return '';
}
