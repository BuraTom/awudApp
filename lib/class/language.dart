class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(1, "ET", "አማርኛ", "am"),
      Language(3, "ET", "Afaan Oromoo", "om"),
      Language(4, "ET", "ትግሪኛ", "ti"),
    ];
  }
}