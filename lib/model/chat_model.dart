class Chat {
  Chat({required this.from, required this.text}) : date = DateTime.now();
  final From from;
  String text;
  final DateTime date;
}

enum From { user, model }
