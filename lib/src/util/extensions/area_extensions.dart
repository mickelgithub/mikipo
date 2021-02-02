import 'package:mikipo/src/domain/entity/organization/area.dart';

extension AreaExtensions on Area {

  Map<String, dynamic> toMap() => {
    Area.ID: this.id,
    Area.NAME: this.name,
    Area.ICON: this.icon
  };

}