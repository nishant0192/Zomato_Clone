import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String email;
  final String mobile;
  final String dob;
  final String anniversary;
  final String gender;
  final int savedAmount;

  UserProfile({
    required this.name,
    required this.email,
    this.mobile = '',
    this.dob = '',
    this.anniversary = '',
    this.gender = 'Male',
    this.savedAmount = 0,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? mobile,
    String? dob,
    String? anniversary,
    String? gender,
    int? savedAmount,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      dob: dob ?? this.dob,
      anniversary: anniversary ?? this.anniversary,
      gender: gender ?? this.gender,
      savedAmount: savedAmount ?? this.savedAmount,
    );
  }
}

// Global state for simplicity across the app
final ValueNotifier<UserProfile> currentUserNotifier =
    ValueNotifier<UserProfile>(
      UserProfile(
        name: 'Guest User',
        email: 'guest@example.com',
        mobile: '9876543210',
        dob: '01/01/2000',
        savedAmount: 0,
      ),
    );
