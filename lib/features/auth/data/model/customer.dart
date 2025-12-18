class Customer {
  final int id;
  final String fullName;
  final String nationalId;
  final String phone;
  final String address;
  final String birthDate;

  Customer({
    required this.id,
    required this.fullName,
    required this.nationalId,
    required this.phone,
    required this.address,
    required this.birthDate,
  });


  Customer copyWith({
    int? id,
    String? fullName,
    String? nationalId,
    String? phone,
    String? address,
    String? birthDate,
    }) {
    return Customer(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nationalId: nationalId ?? this.nationalId,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
    );
  }


  factory Customer.initial() => Customer(
    id: -1,
    fullName: 'fullName',
    nationalId: "",
    phone: "",
    address: "",
    birthDate: "",
  );

  factory Customer.fromMap(Map<String, dynamic> map) => Customer(
    id: map["id"],
    fullName: map["full_name"],
    nationalId: map["national_id"],
    phone: map["phone"],
    address: map["address"],
    birthDate: map["birth_date"],
  );
}
