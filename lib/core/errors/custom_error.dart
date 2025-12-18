import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomError extends Equatable {
  final int status;
  final List<String> messages;
  final Widget page;

  const CustomError({
    required this.status,
    required this.messages,
    this.page = const SizedBox(),
  });

  factory CustomError.initial() => const CustomError(
        status: -1000,
        messages: [],
        page: Placeholder(),
      );

  CustomError copyWith({
    int? status,
    List<String>? messages,
    Widget? page,
  }) {
    return CustomError(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'CustomError{status: $status, messages: $messages, page: $page}';
  }

  @override
  List<Object> get props => [status, messages, page];
}
