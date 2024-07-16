class ChangeFavoriteMode {
  final bool status ;
  final String message ;

  ChangeFavoriteMode({required this.status, required this.message});

  factory ChangeFavoriteMode.fromJson(json)
  {
    return ChangeFavoriteMode(
        status: json['status'],
        message: json['message'],
    );
  }
}