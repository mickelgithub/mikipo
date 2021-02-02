import 'package:mikipo/src/domain/entity/organization/section.dart';

extension SectionExtensions on Section {

  Map<String, dynamic> toMap() => {
    Section.ID: this.id,
    Section.NAME: this.name,
    Section.ICON: this.icon
  };

}