extension DurationExtension on Duration {

  String toTwoDigits(int n){
    if(n >= 10) return '$n' ;
    return '0$n' ;
  }

  //05:15
  String toHoursMinutes (){
    String twoDigitMinutes = toTwoDigits(inMinutes.remainder(60)) ;
    return '${toTwoDigits(inHours)}:$twoDigitMinutes';
  }

  //05:15:35
  String toHoursMinutesSeconds (){
    String twoDigitMinutes = toTwoDigits(inMinutes.remainder(60)) ;
    String twoDigitSeconds= toTwoDigits(inSeconds.remainder(60)) ;
    return '${toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  String toMinutesSeconds (){
    String twoDigitMinutes = toTwoDigits(inMinutes.remainder(60)) ;
    String twoDigitSeconds= toTwoDigits(inSeconds.remainder(60)) ;
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}