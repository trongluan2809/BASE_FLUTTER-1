class GitResponse {
  List<RepoModel> items;

  GitResponse({required this.items});

  factory GitResponse.fromJson(dynamic json) {
    List<dynamic> list = json["items"];
    var result = list.map((e) => RepoModel.fromJson(e)).toList();
    return GitResponse(items: result);
  }

  @override
  String toString() {
    return items.toString();
  }
}

class RepoModel {
  String fullName;
  Owner owner;

  RepoModel({required this.fullName,required this.owner});

  factory RepoModel.fromJson(dynamic json) {
    return RepoModel(
      fullName: json['full_name'],
      owner: Owner.fromJson(json['owner']),
    );
  }

  @override
  String toString() {
    return "\nfullName: $fullName"
        "\nowner: $owner\n";
  }
}

class Owner {
  String avatarUrl;

  Owner({required this.avatarUrl});

  factory Owner.fromJson(dynamic json) {
    return Owner(avatarUrl: json['avatar_url']);
  }
  @override
  String toString() {
    return "avatarUrl: $avatarUrl";
  }
}
