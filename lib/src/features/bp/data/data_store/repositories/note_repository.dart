import 'package:nishauri/src/features/bp/data/data_store/repositories/repository.dart';
import 'package:nishauri/src/features/bp/data/data_store/types/note.dart';

/// Repository for accessing [Note]s stored in a [DatabaseManager] managed db.
abstract class NoteRepository extends Repository<Note> {}
