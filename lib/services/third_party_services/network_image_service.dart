import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:path_provider/path_provider.dart';


///Servie class to handle initialization of the [fast_cached_network_image] package
class NetworkImageService {
  static Future<void> initializeCachedNetworkImage() async {
    final appDir = await getApplicationDocumentsDirectory();
    final path = appDir.path;

    await FastCachedImageConfig.init(subDir: path, clearCacheAfter: const Duration(days: 7));
  }

  static bool checkIfImageIsCached(String url) => FastCachedImageConfig.isCached(imageUrl: url);
}