// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final Timestamp createdAt;
  UserModel({
    Timestamp? createdAt,
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  }) : createdAt = createdAt ?? Timestamp.now();

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phoneNumber,
    Timestamp? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(uid: doc.id,
        fullName: data["fullName"]??"",
        email: data["email"]??"",
        phoneNumber: data["phoneNumber"]??"",
      createdAt: data["createdAt"]??Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "cratedAt": createdAt,
    };
  }
}
