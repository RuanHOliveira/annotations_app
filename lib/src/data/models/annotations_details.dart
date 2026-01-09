class AnnotationsDetails {
  // Registros
  final int totalCreated; // todos
  final int totalActive; // ativos
  final int totalDeleted; // deletados

  // Edições
  final int totalEdits; // soma edições de ativos + deletados

  // Chars
  final int totalCharsActive;
  final int totalCharsDeleted;
  final int totalCharsAll;

  // Letters
  final int totalLettersActive;
  final int totalLettersDeleted;
  final int totalLettersAll;

  // Numbers
  final int totalNumbersActive;
  final int totalNumbersDeleted;
  final int totalNumbersAll;

  const AnnotationsDetails({
    required this.totalCreated,
    required this.totalActive,
    required this.totalDeleted,
    required this.totalEdits,
    required this.totalCharsActive,
    required this.totalCharsDeleted,
    required this.totalCharsAll,
    required this.totalLettersActive,
    required this.totalLettersDeleted,
    required this.totalLettersAll,
    required this.totalNumbersActive,
    required this.totalNumbersDeleted,
    required this.totalNumbersAll,
  });
}
