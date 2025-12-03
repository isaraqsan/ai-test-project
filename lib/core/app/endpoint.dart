class Endpoint {
  static const String login = '/auth/login';
  static const String profile = '/profile';

  static const String program = '/program';

  static const String promotionOutlet = '/outlet';
  static const String promotionOutletFilled = '/outlet/filled';
  static const String promotionOutletNotFilled = '/outlet/not-filled';
  static const String promotionOutletTransaction = '/transaction';

  static const String areaRegion = '/area/region';
  static const String areaArea = '/area/area';
  static const String areaSubArea = '/area/sub-area';

  static const String globalBrand = '/global/brand';
  static const String globalDisplayType = '/global/display-type';
  static const String globalChannel = '/global/channel';
  static const String globalSubChannel = '/global/sub-channel';

  static const String baseUrlOsmLocation =
      'https://nominatim.openstreetmap.org/reverse';
}
