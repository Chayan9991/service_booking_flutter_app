import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_booking_app/data/model/user_model.dart';
import 'package:service_booking_app/data/repositories/auth/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  Stream<User?>? get authStateChanges => auth.authStateChanges();

  //Sign-In methods
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final formattedPhoneNumber = phoneNumber.replaceAll(
        RegExp(r'\s+'),
        "".trim(),
      );

      final emailExists = await checkEmailExists(email);
      if (emailExists) {
        throw Exception("An account with the same email exists");
      }
      final phoneNumberExists = await checkPhoneNumberExists(
        formattedPhoneNumber,
      );
      if (phoneNumberExists) {
        throw Exception("An account with the same phone number exists");
      }

      //create user with firebase Authentication
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception("Failed to create user.");
      }
      // Create UserModel
      final UserModel user = UserModel(
        uid: userCredential.user!.uid,
        fullName: fullName,
        email: email,
        phoneNumber: formattedPhoneNumber,
      );

      // Save user data to Firestore
      await saveUserData(user);

      return user;
    } catch (e) {
      log("Sign-up error: $e");
      throw Exception("Failed to sign up. Please try again.");
    }
  }

  //Check if the email already Exists in the Firebase
  Future<bool> checkEmailExists(String email) async {
    try {
      final methods = await auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      print("Error checking email: $e");
    }
    return false;
  }

  //check if same phone number exists
  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    final formattedPhoneNumber = phoneNumber.replaceAll(
      RegExp(r'\s+'),
      "".trim(),
    );
    try {
      final querySnapshot =
          await firestore
              .collection("users")
              .where("phoneNumber", isEqualTo: formattedPhoneNumber)
              .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking Phone No: $e");
    }
    return false;
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw Exception("User not found");
      }
      final userData = await getUserData(userCredential.user!.uid);
      return userData;
    } catch (e) {
      log("Login error: $e");
      throw Exception("Failed to Login. Please try again.");
    }
  }

  //sign out
  Future<void> signOut() async {
    await auth.signOut();
  }

  /// Save User Data to Firestore
  Future<void> saveUserData(UserModel user) async {
    try {
      await firestore.collection("users").doc(user.uid).set(user.toMap());
    } catch (e) {
      log("Error saving user data: $e");
      throw Exception("Failed to save user data.");
    }
  }

  /// Get User data
  Future<UserModel> getUserData(String uid) async {
    try {
      final doc = await firestore.collection("users").doc(uid).get();
      if (!doc.exists) {
        throw Exception("User data not found...");
      }
      //user found
      return UserModel.fromFirestore(doc);
    } catch (e) {
      log("Error saving user data: $e");
      throw Exception("Failed to save user data.");
    }
  }
}
