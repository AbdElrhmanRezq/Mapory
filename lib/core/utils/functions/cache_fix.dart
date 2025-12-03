String cacheFix(String url) =>
    '$url?v=${DateTime.now().millisecondsSinceEpoch}';
