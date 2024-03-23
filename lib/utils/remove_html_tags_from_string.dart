String removeHtmlTagsFromStrings({String? content}) {
  if (content == null)
    return '';
  else if (content.indexOf('<p>') > -1) {
    content = content.replaceAll('<p>', '').replaceAll('</p>', '');
  }
  return content;
}
