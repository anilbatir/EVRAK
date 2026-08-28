class TeacherProfile {
  final String fullName;
  final String branch;
  final String title;
  final String phone;
  final String email;
  final String registrationNo;
  final String serviceYears;
  final String employmentType;

  const TeacherProfile({
    this.fullName = '',
    this.branch = '',
    this.title = '',
    this.phone = '',
    this.email = '',
    this.registrationNo = '',
    this.serviceYears = '',
    this.employmentType = '',
  });

  TeacherProfile copyWith({
    String? fullName,
    String? branch,
    String? title,
    String? phone,
    String? email,
    String? registrationNo,
    String? serviceYears,
    String? employmentType,
  }) {
    return TeacherProfile(
      fullName: fullName ?? this.fullName,
      branch: branch ?? this.branch,
      title: title ?? this.title,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      registrationNo: registrationNo ?? this.registrationNo,
      serviceYears: serviceYears ?? this.serviceYears,
      employmentType: employmentType ?? this.employmentType,
    );
  }

  Map<String, String> toVariableMap() {
    return {
      'teacher.fullName': fullName,
      'teacher.branch': branch,
      'teacher.title': title,
      'teacher.phone': phone,
      'teacher.email': email,
      'teacher.registrationNo': registrationNo,
      'teacher.serviceYears': serviceYears,
      'teacher.employmentType': employmentType,
    }..removeWhere((key, value) => value.isEmpty);
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'branch': branch,
        'title': title,
        'phone': phone,
        'email': email,
        'registrationNo': registrationNo,
        'serviceYears': serviceYears,
        'employmentType': employmentType,
      };

  factory TeacherProfile.fromJson(Map<String, dynamic> json) {
    return TeacherProfile(
      fullName: json['fullName'] as String? ?? '',
      branch: json['branch'] as String? ?? '',
      title: json['title'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      registrationNo: json['registrationNo'] as String? ?? '',
      serviceYears: json['serviceYears'] as String? ?? '',
      employmentType: json['employmentType'] as String? ?? '',
    );
  }
}

class SchoolProfile {
  final String name;
  final String code;
  final String city;
  final String district;
  final String address;
  final String principalName;

  const SchoolProfile({
    this.name = '',
    this.code = '',
    this.city = '',
    this.district = '',
    this.address = '',
    this.principalName = '',
  });

  SchoolProfile copyWith({
    String? name,
    String? code,
    String? city,
    String? district,
    String? address,
    String? principalName,
  }) {
    return SchoolProfile(
      name: name ?? this.name,
      code: code ?? this.code,
      city: city ?? this.city,
      district: district ?? this.district,
      address: address ?? this.address,
      principalName: principalName ?? this.principalName,
    );
  }

  Map<String, String> toVariableMap() {
    return {
      'school.name': name,
      'school.code': code,
      'school.city': city,
      'school.district': district,
      'school.address': address,
      'school.principalName': principalName,
    }..removeWhere((key, value) => value.isEmpty);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'city': city,
        'district': district,
        'address': address,
        'principalName': principalName,
      };

  factory SchoolProfile.fromJson(Map<String, dynamic> json) {
    return SchoolProfile(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
      city: json['city'] as String? ?? '',
      district: json['district'] as String? ?? '',
      address: json['address'] as String? ?? '',
      principalName: json['principalName'] as String? ?? '',
    );
  }
}
