class Endpoint {
  //* Auth
  static const String login = '/auth/login';
  static const String profile = '/profile';

  //* Program
  static const String program = '/program';

  //* Promotion Outlet
  static const String promotionOutlet = '/outlet';
  static const String promotionOutletFilled = '/outlet/filled';
  static const String promotionOutletNotFilled = '/outlet/not-filled';
  static const String promotionOutletTransaction = '/transaction';

  //* Area
  static const String areaRegion = '/area/region';
  static const String areaArea = '/area/area';
  static const String areaSubArea = '/area/sub-area';

  //* Global
  static const String globalBrand = '/global/brand';
  static const String globalDisplayType = '/global/display-type';
  static const String globalChannel = '/global/channel';
  static const String globalSubChannel = '/global/sub-channel';

  // * OSM
  static const String baseUrlOsmLocation = 'https://nominatim.openstreetmap.org';
}
