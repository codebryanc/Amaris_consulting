import 'package:flutter_test/flutter_test.dart';
import 'package:amaris_consulting/core/models/fund_entity.dart';
import 'package:amaris_consulting/core/models/fund_category_type.dart';
import 'package:amaris_consulting/core/models/fund_notification_method_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('FundEntity', () {

    test('should create instance with empty constructor', () {
      // Arrange
      // No setup required for empty constructor

      // Act
      final fund = FundEntity.empty();

      // Assert
      expect(fund.id, isNull);
      expect(fund.name, isNull);
      expect(fund.friendlyName, isNull);
      expect(fund.shortName, isNull);
      expect(fund.minAmount, isNull);
      expect(fund.category, isNull);
      expect(fund.isSubscribed, isNull);
      expect(fund.notificationMethodType, isNull);
    });

    test('should create instance with full constructor', () {
      // Arrange
      const int id = 1;
      const String name = 'Test Fund';
      const String friendlyName = 'Test Friendly Fund';
      const String shortName = 'TF';
      const double minAmount = 1000.0;
      const FundCategoryType category = FundCategoryType.fic;
      const bool isSubscribed = true;
      const FundNotificationMethodType notificationMethodType = FundNotificationMethodType.email;

      // Act
      final fund = FundEntity(
        id: id,
        name: name,
        friendlyName: friendlyName,
        shortName: shortName,
        minAmount: minAmount,
        category: category,
        isSubscribed: isSubscribed,
        notificationMethodType: notificationMethodType,
      );

      // Assert
      expect(fund.id, equals(id));
      expect(fund.name, equals(name));
      expect(fund.friendlyName, equals(friendlyName));
      expect(fund.shortName, equals(shortName));
      expect(fund.minAmount, equals(minAmount));
      expect(fund.category, equals(category));
      expect(fund.isSubscribed, equals(isSubscribed));
      expect(fund.notificationMethodType, equals(notificationMethodType));
    });

    test('should create instance with partial constructor parameters', () {
      // Arrange
      const int id = 2;
      const String name = 'Partial Fund';
      const FundCategoryType category = FundCategoryType.fpv;

      // Act
      final fund = FundEntity(
        id: id,
        name: name,
        category: category,
      );

      // Assert
      expect(fund.id, equals(id));
      expect(fund.name, equals(name));
      expect(fund.category, equals(category));
      expect(fund.friendlyName, isNull);
      expect(fund.shortName, isNull);
      expect(fund.minAmount, isNull);
      expect(fund.isSubscribed, isNull);
      expect(fund.notificationMethodType, isNull);
    });

    test('should allow setting and getting id property', () {
      // Arrange
      const int id = 123;
      final fund = FundEntity.empty();

      // Act
      fund.id = id;

      // Assert
      expect(fund.id, equals(id));
    });

    test('should allow setting and getting name property', () {
      // Arrange
      const String name = 'Dynamic Fund Name';
      final fund = FundEntity.empty();

      // Act
      fund.name = name;

      // Assert
      expect(fund.name, equals(name));
    });

    test('should allow setting and getting friendlyName property', () {
      // Arrange
      const String friendlyName = 'User Friendly Fund Name';
      final fund = FundEntity.empty();

      // Act
      fund.friendlyName = friendlyName;

      // Assert
      expect(fund.friendlyName, equals(friendlyName));
    });

    test('should allow setting and getting shortName property', () {
      // Arrange
      const String shortName = 'SFN';
      final fund = FundEntity.empty();

      // Act
      fund.shortName = shortName;

      // Assert
      expect(fund.shortName, equals(shortName));
    });

    test('should allow setting and getting minAmount property', () {
      // Arrange
      const double minAmount = 500.75;
      final fund = FundEntity.empty();

      // Act
      fund.minAmount = minAmount;

      // Assert
      expect(fund.minAmount, equals(minAmount));
    });

    test('should allow setting and getting category property', () {
      // Arrange
      const FundCategoryType category = FundCategoryType.fpv;
      final fund = FundEntity.empty();

      // Act
      fund.category = category;

      // Assert
      expect(fund.category, equals(category));
    });

    test('should allow setting and getting isSubscribed property', () {
      // Arrange
      const bool isSubscribed = false;
      final fund = FundEntity.empty();

      // Act
      fund.isSubscribed = isSubscribed;

      // Assert
      expect(fund.isSubscribed, equals(isSubscribed));
    });

    test('should allow setting and getting notificationMethodType property', () {
      // Arrange
      const FundNotificationMethodType notificationMethodType = FundNotificationMethodType.sms;
      final fund = FundEntity.empty();

      // Act
      fund.notificationMethodType = notificationMethodType;

      // Assert
      expect(fund.notificationMethodType, equals(notificationMethodType));
    });

    test('should return "FIC" for FundCategoryType.fic in getCategoryName', () {
      // Arrange
      final fund = FundEntity(category: FundCategoryType.fic);

      // Act
      final categoryName = fund.getCategoryName();

      // Assert
      expect(categoryName, equals("FIC"));
    });

    test('should return "FPV" for FundCategoryType.fpv in getCategoryName', () {
      // Arrange
      final fund = FundEntity(category: FundCategoryType.fpv);

      // Act
      final categoryName = fund.getCategoryName();

      // Assert
      expect(categoryName, equals("FPV"));
    });

    test('should return empty string for null category in getCategoryName', () {
      // Arrange
      final fund = FundEntity.empty();

      // Act
      final categoryName = fund.getCategoryName();

      // Assert
      expect(categoryName, equals(""));
    });

    test('should handle zero minAmount', () {
      // Arrange
      const double minAmount = 0.0;
      final fund = FundEntity.empty();

      // Act
      fund.minAmount = minAmount;

      // Assert
      expect(fund.minAmount, equals(minAmount));
    });

    test('should handle negative minAmount', () {
      // Arrange
      const double minAmount = -100.0;
      final fund = FundEntity.empty();

      // Act
      fund.minAmount = minAmount;

      // Assert
      expect(fund.minAmount, equals(minAmount));
    });

    test('should handle large minAmount values', () {
      // Arrange
      const double minAmount = 999999999.99;
      final fund = FundEntity.empty();

      // Act
      fund.minAmount = minAmount;

      // Assert
      expect(fund.minAmount, equals(minAmount));
    });

    test('should allow resetting properties to null', () {
      // Arrange
      final fund = FundEntity(
        id: 1,
        name: 'Test Fund',
        friendlyName: 'Friendly Test Fund',
        shortName: 'TF',
        minAmount: 1000.0,
        category: FundCategoryType.fic,
        isSubscribed: true,
        notificationMethodType: FundNotificationMethodType.email,
      );

      // Act
      fund.id = null;
      fund.name = null;
      fund.friendlyName = null;
      fund.shortName = null;
      fund.minAmount = null;
      fund.category = null;
      fund.isSubscribed = null;
      fund.notificationMethodType = null;

      // Assert
      expect(fund.id, isNull);
      expect(fund.name, isNull);
      expect(fund.friendlyName, isNull);
      expect(fund.shortName, isNull);
      expect(fund.minAmount, isNull);
      expect(fund.category, isNull);
      expect(fund.isSubscribed, isNull);
      expect(fund.notificationMethodType, isNull);
    });

    test('should handle empty string values', () {
      // Arrange
      const String emptyString = '';
      final fund = FundEntity.empty();

      // Act
      fund.name = emptyString;
      fund.friendlyName = emptyString;
      fund.shortName = emptyString;

      // Assert
      expect(fund.name, equals(emptyString));
      expect(fund.friendlyName, equals(emptyString));
      expect(fund.shortName, equals(emptyString));
    });

    test('should handle very long string values', () {
      // Arrange
      const String longString = 'This is a very long fund name that might be used in extreme cases to test the robustness of the entity';
      final fund = FundEntity.empty();

      // Act
      fund.name = longString;
      fund.friendlyName = longString;
      fund.shortName = longString;

      // Assert
      expect(fund.name, equals(longString));
      expect(fund.friendlyName, equals(longString));
      expect(fund.shortName, equals(longString));
    });

    test('should handle special characters in string properties', () {
      // Arrange
      const String specialChars = 'Fund@123#\$%^&*()_+-=[]{}|;:",.<>?';
      final fund = FundEntity.empty();

      // Act
      fund.name = specialChars;
      fund.friendlyName = specialChars;
      fund.shortName = specialChars;

      // Assert
      expect(fund.name, equals(specialChars));
      expect(fund.friendlyName, equals(specialChars));
      expect(fund.shortName, equals(specialChars));
    });
  });
}