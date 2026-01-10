class AnnotationsDetails {
  // Registros
  final int totalCreated; // total de registros criados
  final int totalActive; // total de registros ativos
  final int totalDeleted; // total de registros deletados

  // Edições
  final int totalEditsActive; // soma de edições de ativos
  final int totalEditsDeleted; // soma de edições de deletados
  final int totalEditsAll; // soma de edições de ativos + deletados

  // Caracteres
  final int totalCharsActive; // soma de caracteres de ativos
  final int totalCharsDeleted; // soma de caracteres de deletados
  final int totalCharsAll; // soma de caracteres de ativos + deletados

  // Letras
  final int totalLettersActive; // soma de letras de ativos
  final int totalLettersDeleted; // soma de letras de deletados
  final int totalLettersAll; // soma de letras de ativos + deletados

  // Números
  final int totalNumbersActive; // soma de números de ativos
  final int totalNumbersDeleted; // soma de números de deletados
  final int totalNumbersAll; // soma de números de ativos + deletados

  // Vazios (em branco)
  final int totalEmptyActive; // soma de vazios de ativos
  final int totalEmptyDeleted; // soma de vazios de deletados
  final int totalEmptyAll; // soma de vazios de ativos + deletados

  // Especials (ex: !#$@)
  final int totalSpecialActive; // soma de caracteres especiais de ativos
  final int totalSpecialDeleted; // soma de caracteres especiais de deletados
  final int
  totalSpecialAll; // soma de caracteres especiais de ativos + deletados

  const AnnotationsDetails({
    required this.totalCreated,
    required this.totalActive,
    required this.totalDeleted,
    required this.totalEditsActive,
    required this.totalEditsDeleted,
    required this.totalEditsAll,
    required this.totalCharsActive,
    required this.totalCharsDeleted,
    required this.totalCharsAll,
    required this.totalLettersActive,
    required this.totalLettersDeleted,
    required this.totalLettersAll,
    required this.totalNumbersActive,
    required this.totalNumbersDeleted,
    required this.totalNumbersAll,
    required this.totalEmptyActive,
    required this.totalEmptyDeleted,
    required this.totalEmptyAll,
    required this.totalSpecialActive,
    required this.totalSpecialDeleted,
    required this.totalSpecialAll,
  });

  factory AnnotationsDetails.empty() {
    return const AnnotationsDetails(
      totalCreated: 0,
      totalActive: 0,
      totalDeleted: 0,
      totalEditsActive: 0,
      totalEditsDeleted: 0,
      totalEditsAll: 0,
      totalCharsActive: 0,
      totalCharsDeleted: 0,
      totalCharsAll: 0,
      totalLettersActive: 0,
      totalLettersDeleted: 0,
      totalLettersAll: 0,
      totalNumbersActive: 0,
      totalNumbersDeleted: 0,
      totalNumbersAll: 0,
      totalEmptyActive: 0,
      totalEmptyDeleted: 0,
      totalEmptyAll: 0,
      totalSpecialActive: 0,
      totalSpecialDeleted: 0,
      totalSpecialAll: 0,
    );
  }
}
