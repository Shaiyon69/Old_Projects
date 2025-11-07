class Audit {
  // int? userId;
  String? activity_log;
  String? action;

  Audit({this.activity_log, this.action});

  factory Audit.fromJson(Map<String, dynamic> json) {
    return Audit(
      // userId: json['user_id'] != null
      //     ? int.tryParse(json['user_id'].toString())
      //     : null,
      activity_log: json['activity_log']?.toString(),
      action: json['action']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'user_id': userId?.toString() ?? '',
      'activity_log': activity_log?.toString() ?? '',
      'action': action?.toString() ?? '',
    };
  }
}
