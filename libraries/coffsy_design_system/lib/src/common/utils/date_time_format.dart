class DateTimeFormat {
  static String day(int dayWeek) {
    switch (dayWeek) {
      case 1:
        return 'MO';
      case 2:
        return 'TU';
      case 3:
        return 'WE';
      case 4:
        return 'TH';
      case 5:
        return 'FR';
      case 6:
        return 'SA';
      case 7:
        return 'SU';
      default:
        return 'MO';
    }
  }
}
