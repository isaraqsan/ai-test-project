enum Role {
  superAdmin(1, 'super_admin'),
  admin(2, 'admin'),
  headOffice(3, 'head_office'),
  implementor(4, 'implementor'),
  unknow(99, 'unknown');

  final int code;
  final String name;

  const Role(this.code, this.name);
  factory Role.fromCode(String? type) {
    return type != null
        ? Role.values.firstWhere(
            (e) => e.name == type.toLowerCase(),
            orElse: () => Role.unknow,
          )
        : Role.unknow;
  }
}
