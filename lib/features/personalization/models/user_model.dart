import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_e_com/utils/formatters/formatter.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.profilePic,
  });

  final String id, email, username, phoneNumber;

  String firstName, lastName, profilePic;

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullname) => fullname.split(' ');

  static String generateUsername(fullname) {
    List<String> nameParts = fullname.split(' ');
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';
    String camelCaseUsername = '$firstName$lastName';
    return 'cwt_$camelCaseUsername';
  }

  static UserModel empty() => UserModel(
        email: '',
        username: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        id: '',
        profilePic: '',
      );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      final json = doc.data()!;
      return UserModel(
        id: doc.id,
        firstName: json['FirstName'] ?? '',
        lastName: json['LastName'] ?? '',
        email: json['Email'] ?? '',
        username: json['Username'] ?? '',
        phoneNumber: json['PhoneNumber'] ?? '',
        profilePic: json['ProfilePic'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Username': username,
      'PhoneNumber': phoneNumber,
      'ProfilePic': profilePic,
    };
  }
}
