import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int balance;

  User({@required this.id, @required this.name, @required this.balance});

  @override
  List<Object> get props => [id, name, balance];
}
