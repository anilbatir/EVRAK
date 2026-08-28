import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/data/catalog_seed.dart';

void main() {
  test('catalog seed has 50 unique, inactive draft entries', () {
    expect(catalogSeed.length, 50);

    final ids = catalogSeed.map((t) => t.id).toSet();
    expect(ids.length, 50, reason: 'template ids must be unique');

    for (final template in catalogSeed) {
      expect(template.isActive, isFalse,
          reason: '${template.id} should not be active until it has a real body template');
      expect(template.bodyText, isEmpty,
          reason: '${template.id} is metadata-only and must not be rendered yet');
    }
  });
}
