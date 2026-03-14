import '../models/auth/user_permission_model.dart';

/// A singleton service to manage user UI permissions throughout the app.
class PermissionService {
  /// Private constructor
  PermissionService._();

  /// The static instance of the service.
  static final instance = PermissionService._();

  List<UserPermissionModel> _permissions = [];

  /// Initializes the service with the list of permissions for the current user.
  /// This should be called once after login.
  void init(List<UserPermissionModel> permissionsData) {
    _permissions = permissionsData;
  }

  /// Clears all permissions. This should be called on logout.
  void clear() {
    _permissions = [];
  }

  /// A generic method to check for a specific permission.
  bool _hasPermission(String uiName, String pageName) {
    return _permissions.any((p) => p.uiName == uiName && p.pageName == pageName);
  }

  // --- FlightConfirmation Page ---
  bool get canAssignFlightConfirmation => _hasPermission('Assign', 'FlightConfirmation');

  bool get canApproveFlightConfirmation => _hasPermission('Approve', 'FlightConfirmation');

  bool get canRejectFlightConfirmation => _hasPermission('Reject', 'FlightConfirmation');

  // --- Drawer ---
  bool get canViewFlightsDrawer => _hasPermission('Flights', 'Drawer');

  bool get canViewUsersDrawer => _hasPermission('Users', 'Drawer');

  bool get canViewAircraftDrawer => _hasPermission('Aircraft', 'Drawer');

  bool get canViewReportDrawer => _hasPermission('Report', 'Drawer');

  // --- FlightDetailsHeader ---
  bool get canViewGeneralFlightDetails => _hasPermission('General', 'FlightDetailsHeader');

  bool get canViewServiceFlightDetails => _hasPermission('Service', 'FlightDetailsHeader');

  bool get canViewChargeFlightDetails => _hasPermission('Charge', 'FlightDetailsHeader');

  // --- FlightService ---
  bool get canAddFlightService => _hasPermission('Add', 'FlightService');

  bool get canDeleteFlightService => _hasPermission('Delete', 'FlightService');

  bool get canSubmitFlightService => _hasPermission('ServiceSubmit', 'FlightService');
}
