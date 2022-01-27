class StatisticMenuMonthlyBooksCubitState {
  Map<DateTime, int> readingBookCountData;

  StatisticMenuMonthlyBooksCubitState({
    required this.readingBookCountData,
  });

  static StatisticMenuMonthlyBooksCubitState initialState =
      StatisticMenuMonthlyBooksCubitState(readingBookCountData: {});

  StatisticMenuMonthlyBooksCubitState copyWith({
    Map<DateTime, int>? readingBookCountData,
  }) {
    return StatisticMenuMonthlyBooksCubitState(
      readingBookCountData: readingBookCountData ?? this.readingBookCountData,
    );
  }
}
