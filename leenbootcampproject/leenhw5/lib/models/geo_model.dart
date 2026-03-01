class GeoModel {
  final double lat;
  final double lng;

  GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.fromMap(Map<String, dynamic> json) {
    return GeoModel(
      lat: double.parse(json['lat'].toString()),
      lng: double.parse(json['lng'].toString()),
    );
  }
}
