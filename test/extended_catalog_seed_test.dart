import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/data/extended_catalog_seed.dart';

void main() {
  test('extended catalog seed has 10 unique, inactive draft entries', () {
    expect(extendedCatalogSeed.length, 10);

    final ids = extendedCatalogSeed.map((t) => t.id).toSet();
    expect(ids.length, 10, reason: 'template ids must be unique');

    for (final template in extendedCatalogSeed) {
      expect(template.isActive, isFalse,
          reason: '${template.id} should not be active until it has a real body template');
      expect(template.bodyText, isEmpty,
          reason: '${template.id} is metadata-only and must not be rendered yet');
    }
  });
}
