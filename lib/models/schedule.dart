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
      this.redCard = const [0, 0],
      this.yellowCard = const [0, 0],
      this.half,
      this.note,
      this.scoreAll = const [0, 0],
      this.scorePoint = const [0, 0],
      this.weather,
      this.stats});

  factory Schedule.parse(Map<String, dynamic> d) {
    var _id = List.from(d['Id']).map((e) => e as int).toList();
    var _rank = List.from(d['Rank']).map((e) => e as String).toList();
    var _score = List.from(d['Score']).map((e) => e as int).toList();
    var _redCard = d['RedCard'] != null
        ? List.from(d['RedCard']).map((e) => e as int).toList()
        : [0, 0];
    var _yellowCard = d['YellowCard'] != null
        ? List.from(d['YellowCard']).map((e) => e as int).toList()
        : [0, 0];
    var _socreAll = d['SocreAll'] != null
        ? List.from(d['SocreAll']).map((e) => e as int).toList()
        : [0, 0];
    var _socrePoint = d['SocrePoint'] != null
        ? List.from(d['SocrePoint']).map((e) => e as int).toList()
        : [0, 0];
    var _stats = d['Stats'] != null ? Stats.parse(d['Stats']) : Stats();

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
  Stats({
    this.flag = const [0, 0, 0, 0, 0, 0, 0, 0],
    this.data = const [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  });
  factory Stats.parse(Map<String, dynamic> d) {
    var _flag = List.from(d['Flag']).map((e) => e as int).toList();
    var _data = List.from(d['Data']).map((e) => e as int).toList();
    return Stats(flag: _flag, data: _data);
  }
}

class Competition {
  final int key;
  final String name;
  final String shortName;
  final String color;
  Competition(this.key, this.name, this.shortName, this.color);

  factory Competition.parse(Map<String, dynamic> d) =>
      Competition(d['key'], d['Name'], d['ShortName'], d['color']);
}

class Team {
  final int key;
  final String name;
  final String shortName;
  Team(this.key, this.name, this.shortName);

  factory Team.parse(Map<String, dynamic> d) =>
      Team(d['key'], d['Name'], d['ShortName']);
}
