extension FormatRuntimeMovie on int {
  String formatMinutes() {
    final hours = this ~/ 60;
    final minutes = this % 60;
    return "${hours}h ${minutes.toString().padLeft(2, '0')}min";
  }
}
