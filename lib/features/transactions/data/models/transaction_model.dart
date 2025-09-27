class TransactionModel {
  final String id;
  final String icon;
  final String title;
  final DateTime date;
  final double amount;
  final String status;
  final String paymentMethod;

  TransactionModel({
    required this.id,
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.paymentMethod,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      icon: json['icon'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'title': title,
      'date': date.toIso8601String(),
      'amount': amount,
      'status': status,
      'paymentMethod': paymentMethod,
    };
  }
}
