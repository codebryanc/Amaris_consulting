import 'package:flutter_test/flutter_test.dart';
import 'package:amaris_consulting/dal/fund/data/fund_local_datasource.dart';
import 'package:amaris_consulting/core/models/fund_entity.dart';
import 'package:amaris_consulting/core/models/fund_category_type.dart';
import 'package:amaris_consulting/core/models/fund_notification_method_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('FundLocalDatasource', () {

    test('should implement singleton pattern correctly', () {
      // Arrange
      // No setup required

      // Act
      final instance1 = FundLocalDatasource();
      final instance2 = FundLocalDatasource();

      // Assert
      expect(instance1, equals(instance2));
      expect(identical(instance1, instance2), isTrue);
    });

    test('should return same instance on multiple calls', () {
      // Arrange
      final firstInstance = FundLocalDatasource();

      // Act
      final secondInstance = FundLocalDatasource();
      final thirdInstance = FundLocalDatasource();

      // Assert
      expect(firstInstance, equals(secondInstance));
      expect(secondInstance, equals(thirdInstance));
      expect(identical(firstInstance, secondInstance), isTrue);
      expect(identical(secondInstance, thirdInstance), isTrue);
    });

    test('should return initial list of funds from getAvailableFunds', () {
      // Arrange
      final datasource = FundLocalDatasource();

      // Act
      final funds = datasource.getAvailableFunds();

      // Assert
      expect(funds, isNotEmpty);
      expect(funds.length, equals(5));
      expect(funds, isA<List<FundEntity>>());
    });

    test('should return funds with correct initial data', () {
      // Arrange
      final datasource = FundLocalDatasource();

      // Act
      final funds = datasource.getAvailableFunds();

      // Assert
      expect(funds[0].id, equals(1));
      expect(funds[0].name, equals('FPV_BTG_PACTUAL_RECAUDADORA'));
      expect(funds[0].friendlyName, equals('BTG Pactual Recaudadora'));
      expect(funds[0].shortName, equals('Recaudadora'));
      expect(funds[0].minAmount, equals(75000));
      expect(funds[0].category, equals(FundCategoryType.fpv));
      expect(funds[0].isSubscribed, equals(false));
    });

    test('should return funds with different categories', () {
      // Arrange
      final datasource = FundLocalDatasource();

      // Act
      final funds = datasource.getAvailableFunds();

      // Assert
      final fpvFunds = funds.where((fund) => fund.category == FundCategoryType.fpv).toList();
      final ficFunds = funds.where((fund) => fund.category == FundCategoryType.fic).toList();
      
      expect(fpvFunds.length, equals(3));
      expect(ficFunds.length, equals(2));
    });

    test('should successfully update existing fund', () {
      // Arrange
      final datasource = FundLocalDatasource();
      final fundToUpdate = FundEntity(
        id: 1,
        name: 'UPDATED_FUND_NAME',
        friendlyName: 'Updated Friendly Name',
        shortName: 'Updated',
        minAmount: 999999,
        category: FundCategoryType.fic,
        isSubscribed: true,
        notificationMethodType: FundNotificationMethodType.email,
      );

      // Act
      final result = datasource.updateFund(fundToUpdate);

      // Assert
      expect(result, isTrue);
      final updatedFunds = datasource.getAvailableFunds();
      expect(updatedFunds[0].name, equals('UPDATED_FUND_NAME'));
      expect(updatedFunds[0].friendlyName, equals('Updated Friendly Name'));
      expect(updatedFunds[0].shortName, equals('Updated'));
      expect(updatedFunds[0].minAmount, equals(999999));
      expect(updatedFunds[0].category, equals(FundCategoryType.fic));
      expect(updatedFunds[0].isSubscribed, equals(true));
      expect(updatedFunds[0].notificationMethodType, equals(FundNotificationMethodType.email));
    });

    test('should fail to update non-existing fund', () {
      // Arrange
      final datasource = FundLocalDatasource();
      final nonExistingFund = FundEntity(
        id: 999,
        name: 'NON_EXISTING_FUND',
        friendlyName: 'Non Existing Fund',
        shortName: 'NEF',
        minAmount: 1000,
        category: FundCategoryType.fic,
        isSubscribed: false,
      );

      // Act
      final result = datasource.updateFund(nonExistingFund);

      // Assert
      expect(result, isFalse);
    });

    test('should update fund with null values', () {
      // Arrange
      final datasource = FundLocalDatasource();
      final fundWithNulls = FundEntity(
        id: 2,
        name: null,
        friendlyName: null,
        shortName: null,
        minAmount: null,
        category: null,
        isSubscribed: null,
        notificationMethodType: null,
      );

      // Act
      final result = datasource.updateFund(fundWithNulls);

      // Assert
      expect(result, isTrue);
      final updatedFunds = datasource.getAvailableFunds();
      expect(updatedFunds[1].name, isNull);
      expect(updatedFunds[1].friendlyName, isNull);
      expect(updatedFunds[1].shortName, isNull);
      expect(updatedFunds[1].minAmount, isNull);
      expect(updatedFunds[1].category, isNull);
      expect(updatedFunds[1].isSubscribed, isNull);
      expect(updatedFunds[1].notificationMethodType, isNull);
    });

    test('should update multiple funds sequentially', () {
      // Arrange
      final datasource = FundLocalDatasource();
      final fund1 = FundEntity(id: 1, name: 'Updated Fund 1');
      final fund2 = FundEntity(id: 2, name: 'Updated Fund 2');

      // Act
      final result1 = datasource.updateFund(fund1);
      final result2 = datasource.updateFund(fund2);

      // Assert
      expect(result1, isTrue);
      expect(result2, isTrue);
      final updatedFunds = datasource.getAvailableFunds();
      expect(updatedFunds[0].name, equals('Updated Fund 1'));
      expect(updatedFunds[1].name, equals('Updated Fund 2'));
    });

    test('should set notification method type for all funds', () {
      // Arrange
      final datasource = FundLocalDatasource();
      const notificationType = FundNotificationMethodType.email;

      // Act
      final result = datasource.editAllFund(notificationType);

      // Assert
      expect(result, isTrue);
      final funds = datasource.getAvailableFunds();
      for (var fund in funds) {
        expect(fund.notificationMethodType, equals(notificationType));
      }
    });

    test('should set notification method type to SMS for all funds', () {
      // Arrange
      final datasource = FundLocalDatasource();
      const notificationType = FundNotificationMethodType.sms;

      // Act
      final result = datasource.editAllFund(notificationType);

      // Assert
      expect(result, isTrue);
      final funds = datasource.getAvailableFunds();
      for (var fund in funds) {
        expect(fund.notificationMethodType, equals(notificationType));
      }
    });

    test('should set notification method type to null for all funds', () {
      // Arrange
      final datasource = FundLocalDatasource();

      // Act
      final result = datasource.editAllFund(null);

      // Assert
      expect(result, isTrue);
      final funds = datasource.getAvailableFunds();
      for (var fund in funds) {
        expect(fund.notificationMethodType, isNull);
      }
    });

    test('should maintain fund count after editAllFund', () {
      // Arrange
      final datasource = FundLocalDatasource();
      final originalCount = datasource.getAvailableFunds().length;

      // Act
      datasource.editAllFund(FundNotificationMethodType.email);

      // Assert
      final newCount = datasource.getAvailableFunds().length;
      expect(newCount, equals(originalCount));
    });

    test('should preserve other fund properties when editing notification method', () {
      // Arrange
      final datasource = FundLocalDatasource();
      final originalFunds = datasource.getAvailableFunds();
      final firstFundOriginalName = originalFunds[0].name;
      final firstFundOriginalId = originalFunds[0].id;

      // Act
      datasource.editAllFund(FundNotificationMethodType.sms);

      // Assert
      final updatedFunds = datasource.getAvailableFunds();
      expect(updatedFunds[0].name, equals(firstFundOriginalName));
      expect(updatedFunds[0].id, equals(firstFundOriginalId));
      expect(updatedFunds[0].notificationMethodType, equals(FundNotificationMethodType.sms));
    });

    test('should handle empty notification method type changes', () {
      // Arrange
      final datasource = FundLocalDatasource();
      
      // Act
      datasource.editAllFund(FundNotificationMethodType.email);
      datasource.editAllFund(null);
      final result = datasource.editAllFund(FundNotificationMethodType.sms);

      // Assert
      expect(result, isTrue);
      final funds = datasource.getAvailableFunds();
      for (var fund in funds) {
        expect(fund.notificationMethodType, equals(FundNotificationMethodType.sms));
      }
    });

    test('should return same list reference on multiple getAvailableFunds calls', () {
      // Arrange
      final datasource = FundLocalDatasource();

      // Act
      final funds1 = datasource.getAvailableFunds();
      final funds2 = datasource.getAvailableFunds();

      // Assert
      expect(identical(funds1, funds2), isTrue);
    });

    test('should maintain state between different method calls', () {
      // Arrange
      final datasource = FundLocalDatasource();
      final updatedFund = FundEntity(
        id: 1,
        name: 'STATE_TEST_FUND',
        friendlyName: 'State Test Fund',
        shortName: 'STF',
        minAmount: 123456,
        category: FundCategoryType.fic,
        isSubscribed: true,
      );

      // Act
      datasource.updateFund(updatedFund);
      datasource.editAllFund(FundNotificationMethodType.email);
      final finalFunds = datasource.getAvailableFunds();

      // Assert
      expect(finalFunds[0].name, equals('STATE_TEST_FUND'));
      expect(finalFunds[0].friendlyName, equals('State Test Fund'));
      expect(finalFunds[0].shortName, equals('STF'));
      expect(finalFunds[0].minAmount, equals(123456));
      expect(finalFunds[0].category, equals(FundCategoryType.fic));
      expect(finalFunds[0].isSubscribed, equals(true));
      expect(finalFunds[0].notificationMethodType, equals(FundNotificationMethodType.email));
    });

    test('should handle concurrent access to singleton', () {
      // Arrange
      final futures = <Future<FundLocalDatasource>>[];

      // Act
      for (int i = 0; i < 10; i++) {
        futures.add(Future.value(FundLocalDatasource()));
      }

      // Assert
      return Future.wait(futures).then((instances) {
        for (int i = 1; i < instances.length; i++) {
          expect(identical(instances[0], instances[i]), isTrue);
        }
      });
    });
  });
}