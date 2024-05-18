class Language {
  String flag;
  String name;
  String languageCode;

  Language(this.flag, this.name, this.languageCode);

  static List<Language> languagesList=[
    Language('🇺🇸', 'English', 'en'),
    Language('🇪🇬', 'العربية', 'ar'),
    Language('🇪🇸', 'Española', 'es'),
    Language('🇫🇷', 'Française', 'fr'),
  ];
}
