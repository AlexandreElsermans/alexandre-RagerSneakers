class Parseimg {
  static List<String> parseImages(dynamic raw) {
    if (raw == null) return [];
    if (raw is String) return [raw];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    return [];
  }
}