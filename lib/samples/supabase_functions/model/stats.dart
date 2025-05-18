class SubjectAverage {
  final String subject;
  final double avgScore;

  SubjectAverage({required this.subject, required this.avgScore});

  @override
  String toString() =>
      'SubjectAverage(subject: $subject, avgScore: ${avgScore.toStringAsFixed(2)})';
}

class AnswerRatio {
  final int total;
  final int correct;
  final int wrong;
  final double correctRate;

  AnswerRatio(
      {required this.total,
      required this.correct,
      required this.wrong,
      required this.correctRate});

  @override
  String toString() =>
      'AnswerRatio(total: $total, correct: $correct, wrong: $wrong, correctRate: ${(correctRate * 100).toStringAsFixed(1)}%)';
}

class WeeklyTotalScore {
  final String weekLabel;
  final int totalScore;

  WeeklyTotalScore({required this.weekLabel, required this.totalScore});

  @override
  String toString() =>
      'WeeklyTotalScore(week: $weekLabel, totalScore: $totalScore)';
}

class StatsInfo {
  final List<SubjectAverage> subjectAverages;
  final AnswerRatio answerRatio;
  final List<WeeklyTotalScore> weeklyScores;

  StatsInfo(
      {required this.subjectAverages,
      required this.answerRatio,
      required this.weeklyScores});

  @override
  String toString() => '''
StatsInfo(
  subjectAverages: $subjectAverages,
  answerRatio: $answerRatio,
  weeklyScores: $weeklyScores
)''';
}
