class Schedule {
  final List<int> id;
  final int date;
  final int n;
  final List<String> rank;
  final List<int> score;
  final List<int> redCard;
  final List<int> yellowCard;
  final String half;
  final String note;
  final List<int> scoreAll;
  final List<int> scorePoint;
  final String weather;
  final Stats stats;
  Schedule(
      {this.id,
      this.date,
      this.n,
      this.rank,
      this.score,
      this.redCard,
      this.yellowCard,
      this.half,
      this.note,
      this.scoreAll,
      this.scorePoint,
      this.weather,
      this.stats});
  factory Schedule.parse(Map<String, dynamic> d) {
    var _id = List.from(d['Id']).map((e) => e as int).toList();
    var _rank = List.from(d['Rank']).map((e) => e as String).toList();
    var _score = List.from(d['Score']).map((e) => e as int).toList();
    var _redCard = List.from(d['RedCard']).map((e) => e as int).toList();
    var _yellowCard = List.from(d['YellowCard']).map((e) => e as int).toList();
    var _socreAll = List.from(d['SocreAll']).map((e) => e as int).toList();
    var _socrePoint = List.from(d['SocrePoint']).map((e) => e as int).toList();
    var _stats = Stats.parse(d['Stats']);
    return Schedule(
        id: _id,
        date: d['Date'],
        n: d['N'],
        rank: _rank,
        score: _score,
        redCard: _redCard,
        yellowCard: _yellowCard,
        half: d['Half'],
        note: d['Note'],
        scoreAll: _socreAll,
        scorePoint: _socrePoint,
        weather: d['Weather'],
        stats: _stats);
  }
}

class Stats {
  final List<int> flag;
  final List<int> data;
  Stats({this.flag, this.data});
  factory Stats.parse(Map<String, dynamic> d) {
    var _flag = List.from(d['Flag']).map((e) => e as int).toList();
    var _data = List.from(d['Data']).map((e) => e as int).toList();
    return Stats(flag: _flag, data: _data);
  }
}
