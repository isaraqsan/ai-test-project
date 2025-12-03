import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/domain/base/model_api.dart';

class BaseParams extends ModelApi {
  int page = 1;
  int? limit;
  String? sortBy;
  String? sortDir;
  String? name;
  int? siteId;
  int? userId;
  String? startTime;
  String? endTime;
  String? status;
  int? categoryId;
  int? orderId;
  int? supplierId;
  int? programId;
  dynamic id;
  String? search;

  BaseParams({
    this.page = 1,
    this.limit = AppConfig.limitQuery,
    this.sortBy,
    this.sortDir,
    this.name,
    this.siteId,
    this.userId,
    this.startTime,
    this.endTime,
    this.status,
    this.categoryId,
    this.orderId,
    this.supplierId,
    this.programId,
    this.id,
    this.search,
  });

  @override
  BaseParams.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    sortBy = json['sort_by'];
    sortDir = json['sort_dir'];
    name = json['name'];
    siteId = json['site_id'];
    userId = json['user_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    categoryId = json['category_id'];
    orderId = json['order_id'];
    id = json['id'];
    programId = json['program_id'];
    supplierId = json['supplier_id'];
    search = json['search'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['sort_by'] = sortBy;
    data['sort_dir'] = sortDir;
    data['name'] = name;
    data['site_id'] = siteId;
    data['user_id'] = userId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['order_id'] = orderId;
    data['id'] = id;
    data['program_id'] = programId;
    data['supplier_id'] = supplierId;
    data['search'] = search;
    data.removeWhere((key, value) => value == null);
    return data;
  }

  BaseParams.withDate() {
    
    
    
    
  }
}
