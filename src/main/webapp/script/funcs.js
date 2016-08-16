function truncate(str, maxLength, useWordBoundary) {

  if (str==null) return '';
  
  var isTooLong = str.length > maxLength;
  var s_ = isTooLong ? str.substr(0, maxLength - 1) : str;
//     s_ = (useWordBoundary && isTooLong) ? s_.substr(0, s_.lastIndexOf(' ')) : s_;
//     return isTooLong ? s_ + '&hellip;' : s_;
  return s_;
}