class Repo {
  String name;
  String desc;
  Repo({required this.name, required this.desc});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(name: json['name'], desc: json['descripton']);
  }
}

class All {
  List<Repo> repos;
  All({required this.repos});

  factory All.fromJson(List<dynamic> json) {
    List<Repo> repos = [];
    repos = json.map((r) => Repo.fromJson(r)).toList();
    return All(repos: repos);
  }
}
