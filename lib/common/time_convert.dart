class TimeConvert {
  static String convertTime(String time) {
    String result = '00:';
    // if (time != null) {
      if (int.parse(time) < 10) {
        result += '0' + time;
      } else {
        result += time;
      }
    // }
    return result;
  }
}
