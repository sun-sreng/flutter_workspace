import 'dart:convert';
import 'dart:math';

/// Public API for generating IDs and reversible encodings.
///
/// These helpers use [Random] and are not suitable for cryptographic secrets,
/// password reset tokens, or other security-sensitive values.
class IdGenerator {
  static final _IdGeneratorService _service = _IdGeneratorService();

  /// Encodes a list of objects to a Base64 string after JSON serialization.
  ///
  /// This is reversible encoding, not hashing or encryption.
  static String encodeToBase64(List<Object?> objects) {
    return _service.encodeToBase64(objects);
  }

  /// Generates a nanoid-style random ID.
  static String nanoid({int size = 21}) {
    return _service.generateNanoid(size: size);
  }

  /// Generates a random string with configurable character sets.
  static String randomString({
    int length = 8,
    bool useLetters = true,
    bool useNumbers = true,
    bool useSymbols = true,
  }) {
    return _service.generateRandomString(
      length: length,
      useLetters: useLetters,
      useNumbers: useNumbers,
      useSymbols: useSymbols,
    );
  }

  /// Generates a timestamp-based ID with prefix `G`.
  static String timestampId() {
    return _service.generateTimestampId();
  }

  /// Generates a UUID-shaped random ID.
  ///
  /// This is not a standards-compliant UUID v1 generator despite the legacy
  /// method name.
  static String uuidV1() {
    return _service.generateUuidV1();
  }
}

final class _IdGeneratorService {
  _IdGeneratorService({Random? random}) : _random = random ?? Random();

  final Random _random;

  String encodeToBase64(List<Object?> objects) {
    final payload = json.encode(objects);
    final payloadBytes = utf8.encode(payload);
    return base64.encode(payloadBytes);
  }

  String generateNanoid({int size = 21}) {
    if (size <= 0) {
      throw ArgumentError.value(size, 'size', 'must be positive');
    }

    const alphabet = 'ModuleSymbhasOwnPr-0123456789ABCDEFGHNRVfgctiUvz_KqYTJkLxpZXIjQW';
    return _IdGeneratorUtils.generateRandomString(
      length: size,
      characters: alphabet,
      random: _random,
    );
  }

  String generateRandomString({
    int length = 8,
    bool useLetters = true,
    bool useNumbers = true,
    bool useSymbols = true,
  }) {
    if (length <= 0) {
      throw ArgumentError.value(length, 'length', 'must be positive');
    }
    if (!useLetters && !useNumbers && !useSymbols) {
      throw ArgumentError('At least one character set must be enabled');
    }

    var characters = '';
    if (useLetters) characters += _IdGeneratorUtils.alpha;
    if (useNumbers) characters += _IdGeneratorUtils.numbers;
    if (useSymbols) characters += _IdGeneratorUtils.symbols;

    return _IdGeneratorUtils.generateRandomString(
      length: length,
      characters: characters,
      random: _random,
    );
  }

  String generateTimestampId() {
    final special = 8 + _random.nextInt(4);
    return 'G${DateTime.now().millisecondsSinceEpoch}-'
        '${_IdGeneratorUtils.printDigits(special, 1)}'
        '${_IdGeneratorUtils.generateBits(_random, 12, 3)}-'
        '${_IdGeneratorUtils.generateBits(_random, 12, 4)}';
  }

  String generateUuidV1() {
    final special = 8 + _random.nextInt(4);
    return '${_IdGeneratorUtils.generateBits(_random, 16, 4)}'
        '${_IdGeneratorUtils.generateBits(_random, 16, 4)}-'
        '${_IdGeneratorUtils.generateBits(_random, 16, 4)}-'
        '4${_IdGeneratorUtils.generateBits(_random, 12, 3)}-'
        '${_IdGeneratorUtils.printDigits(special, 1)}'
        '${_IdGeneratorUtils.generateBits(_random, 12, 3)}-'
        '${_IdGeneratorUtils.generateBits(_random, 16, 4)}'
        '${_IdGeneratorUtils.generateBits(_random, 16, 4)}'
        '${_IdGeneratorUtils.generateBits(_random, 16, 4)}';
  }
}

final class _IdGeneratorUtils {
  static const alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const numbers = '0123456789';
  static const symbols = '!@#\$%^&*_-+=';

  static String generateBits(Random random, int bitCount, int digitCount) {
    final value = random.nextInt(1 << bitCount);
    return printDigits(value, digitCount);
  }

  static String generateRandomString({
    required int length,
    required String characters,
    required Random random,
  }) {
    final codeUnits = List.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    );
    return String.fromCharCodes(codeUnits);
  }

  static String printDigits(int value, int count) {
    return value.toRadixString(16).padLeft(count, '0');
  }
}
