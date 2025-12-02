class Auth {
  User? user;
  Group? group;
  RoleAuth? role;

  Auth({this.user, this.group, this.role});

  Auth.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    group = json['group'];
    role = json['role'] != null ? RoleAuth.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['group'] = group;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.name, this.username, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Group {}

class RoleAuth {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Access>? access;

  RoleAuth({this.id, this.name, this.createdAt, this.updatedAt, this.access});

  RoleAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['access'] != null) {
      access = <Access>[];
      json['access'].forEach((v) {
        access!.add(Access.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (access != null) {
      data['access'] = access!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Access {
  int? id;
  String? menu;
  String? path;
  bool? isCreate;
  bool? isRead;
  bool? isUpdate;
  bool? isDelete;
  bool? isMaintenece;
  String? createdAt;
  String? updatedAt;

  Access({this.id, this.menu, this.path, this.isCreate, this.isRead, this.isUpdate, this.isDelete, this.isMaintenece, this.createdAt, this.updatedAt});

  Access.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menu = json['menu'];
    path = json['path'];
    isCreate = json['is_create'];
    isRead = json['is_read'];
    isUpdate = json['is_update'];
    isDelete = json['is_delete'];
    isMaintenece = json['is_maintenece'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['menu'] = menu;
    data['path'] = path;
    data['is_create'] = isCreate;
    data['is_read'] = isRead;
    data['is_update'] = isUpdate;
    data['is_delete'] = isDelete;
    data['is_maintenece'] = isMaintenece;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
