class Ayah {
  final int number;
  final String text;
  final Edition edition;
  final Surah surah;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;

  Ayah({
    required this.number,
    required this.text,
    required this.edition,
    required this.surah,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      text: json['text'],
      edition: Edition.fromJson(json['edition']),
      surah: Surah.fromJson(json['surah']),
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      manzil: json['manzil'],
      page: json['page'],
      ruku: json['ruku'],
      hizbQuarter: json['hizbQuarter'],
      sajda: json['sajda'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'edition': edition.toJson(),
      'surah': surah.toJson(),
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
    };
  }
}

class Edition {
  final String identifier;
  final String format;
  final String type;
  final String direction;

  Edition({
    required this.identifier,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) {
    return Edition(
      identifier: json['identifier'],
      format: json['format'],
      type: json['type'],
      direction: json['direction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'format': format,
      'type': type,
      'direction': direction,
    };
  }
}

class Surah {
  final int number;
  final String name;
  final int numberOfAyahs;
  final String revelationType;

  Surah({
    required this.number,
    required this.name,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'numberOfAyahs': numberOfAyahs,
      'revelationType': revelationType,
    };
  }
}

class ApiResponse {
  final int code;
  final String status;
  final Ayah data;

  ApiResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      status: json['status'],
      data: Ayah.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'data': data.toJson(),
    };
  }
}
