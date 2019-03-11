class User{
  String email;
  String password;
  String firstName;
  String lastName;
  String city;
  String contactNumber;
  String userName;

  User(
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.password,
    this.city,
    this.contactNumber
  );

  User.fromJson(Map<String, dynamic> json){
    this.firstName = json['firstName'];
    this.lastName = json['lastName'];
    this.userName = json['userName'];
    this.email = json['email'];
    this.password = json['password'];
    this.city = json['city'];
    this.contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson() =>
    {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'password': password,
      'city': city,
      'contactNumber': contactNumber
    };
}