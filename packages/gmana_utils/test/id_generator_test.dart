import 'dart:convert';

import 'package:gmana_utils/gmana_utils.dart';
import 'package:test/test.dart';

void main() {
  group('IdGenerator', () {
    test('encodeToBase64 encodes JSON payloads reversibly', () {
      final encoded = IdGenerator.encodeToBase64(['user', 123]);
      final decoded = json.decode(utf8.decode(base64.decode(encoded)));

      expect(decoded, ['user', 123]);
    });

    test('encodeToBase64 surfaces unsupported JSON values', () {
      expect(
        () => IdGenerator.encodeToBase64([Object()]),
        throwsA(isA<JsonUnsupportedObjectError>()),
      );
    });

    test('nanoid validates size', () {
      expect(IdGenerator.nanoid(size: 10), hasLength(10));
      expect(() => IdGenerator.nanoid(size: 0), throwsArgumentError);
    });

    test('randomString validates length and character sets', () {
      expect(IdGenerator.randomString(length: 12), hasLength(12));
      expect(() => IdGenerator.randomString(length: 0), throwsArgumentError);
      expect(
        () => IdGenerator.randomString(
          useLetters: false,
          useNumbers: false,
          useSymbols: false,
        ),
        throwsArgumentError,
      );
    });

    test('timestamp and UUID-shaped IDs use expected shapes', () {
      expect(IdGenerator.timestampId(), startsWith('G'));
      expect(
        IdGenerator.uuidV4Like(),
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
    });

    test('legacy uuidV1 name delegates to the v4-shaped generator', () {
      // ignore: deprecated_member_use
      expect(IdGenerator.uuidV1(), contains('-4'));
    });
  });
}
