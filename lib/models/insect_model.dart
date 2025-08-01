class InsectModel {
  final int? id;
  final int? userId;
  final String name;
  final String description;
  final String activeTime;
  final String location;
  final bool dangerous;
  final String diet;
  final String scientificName;
  final String imageUrl;
  final DateTime lastSeenTime;
  final String insectType;
  final String flowerPreference;
  final String lifespan;
  final String frequency;
  final String activityPeriod;
  final String abilities;
  final double size;
  final String regions;

  InsectModel({
    this.id,
    this.userId,
    required this.name,
    required this.description,
    required this.activeTime,
    required this.location,
    required this.dangerous,
    required this.diet,
    required this.scientificName,
    required this.imageUrl,
    required this.lastSeenTime,
    required this.insectType,
    required this.flowerPreference,
    required this.lifespan,
    required this.frequency,
    required this.activityPeriod,
    required this.abilities,
    required this.size,
    required this.regions,
  });

  factory InsectModel.fromJson(Map<String, dynamic> json) {
    return InsectModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      activeTime: json['activeTime'] ?? '',
      location: json['location'] ?? '',
      dangerous: (json['dangerous'] ?? 0) == 1,
      diet: json['diet'] ?? '',
      scientificName: json['scientificName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      lastSeenTime: json['lastSeenTime'] != null
          ? DateTime.tryParse(json['lastSeenTime']) ?? DateTime.now()
          : DateTime.now(),
      insectType: json['insectType'] ?? '',
      flowerPreference: json['flowerPreference'] ?? '',
      lifespan: json['lifespan'] ?? '',
      frequency: json['frequency'] ?? '',
      activityPeriod: json['activityPeriod'] ?? '',
      abilities: json['abilities'] ?? '',
      size: (json['size'] is int)
          ? (json['size'] as int).toDouble()
          : (json['size'] ?? 0.0).toDouble(),
      regions: json['regions'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'userId': userId,
      'name': name,
      'description': description,
      'activeTime': activeTime,
      'location': location,
      'dangerous': dangerous ? 1 : 0,
      'diet': diet,
      'scientificName': scientificName,
      'imageUrl': imageUrl,
      'lastSeenTime': lastSeenTime.toIso8601String(),
      'insectType': insectType,
      'flowerPreference': flowerPreference,
      'lifespan': lifespan,
      'frequency': frequency,
      'activityPeriod': activityPeriod,
      'abilities': abilities,
      'size': size,
      'regions': regions,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }
}
