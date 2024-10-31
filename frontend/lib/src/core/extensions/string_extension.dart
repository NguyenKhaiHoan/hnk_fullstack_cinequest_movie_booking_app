// Sử dụng để tìm các text trong ứng dụng được dùng để localization
import 'package:intl/intl.dart';

extension HardcodedExtenstion on String {
  String get hardcoded => this;
}

extension TimeAgoExtension on String {
  String timeAgo() {
    final time = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(this, true);
    final diff = DateTime.now().difference(time);

    if (diff.inDays >= 7) {
      return '${(diff.inDays / 7).floor()} w ago';
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} d ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} h ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} s ago';
    } else {
      return 'Just now';
    }
  }
}
