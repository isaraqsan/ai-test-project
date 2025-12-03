import 'package:gibas/core/utils/log.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
export 'package:gibas/core/app/database_key.dart';

class DatabaseService extends GetxService {
  late GetStorage getStorage;

  Future<DatabaseService> init() async {
    await GetStorage.init();
    getStorage = GetStorage();
    await registerAdapter();
    return this;
  }

  Future write(String key, dynamic value) => getStorage.write(key, value);

  Future<dynamic> read(String key) async => await getStorage.read(key);

  Future<void> remove(String key) async => getStorage.remove(key);

  bool hasData(String key) => getStorage.hasData(key);

  Future clear() async => getStorage.erase();

  Future registerAdapter() async {
    Log.v('Register Adapter', tag: runtimeType.toString());
    
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }

  Future<bool> clearDatasource() async {
    Log.v('Clear Datasource', tag: runtimeType.toString());
    try {
      await clear();
      return true;
    } catch (e) {
      Log.e('Clear Datasource Error => $e', tag: runtimeType.toString());
      return false;
    }
  }
}
