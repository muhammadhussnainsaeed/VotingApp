import 'dart:typed_data';

class Person {
  String cnic;
  String name;
  DateTime dateOfBirth;
  int pin;
  Uint8List imageData;
  String district;

  Person({
    required this.cnic,
    required this.name,
    required this.dateOfBirth,
    required this.pin,
    required this.imageData,
    required this.district,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      cnic: json['CNIC'],
      name: json['Name'],
      dateOfBirth: DateTime.parse(json['DateOfBirth']),
      pin: json['Pin'],
      imageData: Uint8List.fromList(List<int>.from(json['ImageData'])),
      district: json['District'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CNIC': cnic,
      'Name': name,
      'DateOfBirth': dateOfBirth.toIso8601String(),
      'Pin': pin,
      'ImageData': imageData,
      'District': district,
    };
  }
}
