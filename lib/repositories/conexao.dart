import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static const _dbname = "myvan.db";
  static const _sqlMotorista =
      'CREATE TABLE MOTORISTA(codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT)';
  static const _sqlTipoVeiculo =
      'CREATE TABLE TIPO_VEICULO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT)';
  static const _sqlVeiculo =
      'CREATE TABLE VEICULO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, tipo_veiculo_codigo INTEGER, placa TEXT, cor TEXT, capacidade_passageiros INTEGER, FOREIGN KEY (tipo_veiculo_codigo) REFERENCES TIPO_VEICULO(codigo))';
  static const _sqlPassageiro =
      'CREATE TABLE PASSAGEIRO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, endereco_codigo INTEGER)';
  static const _sqlEndereco =
      'CREATE TABLE ENDERECO(codigo INTEGER PRIMARY KEY AUTOINCREMENT, rua TEXT, bairro TEXT, numero INTEGER, cidade TEXT)';

  Conexao._privateConstructor();
  static final Conexao instance = Conexao._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final database = await openDatabase(join(dbPath, _dbname), version: 1,
        onCreate: (db, version) async {
      await db.execute(_sqlMotorista);
      await db.execute(_sqlTipoVeiculo);
      await db.execute(_sqlVeiculo);
      await db.execute(_sqlEndereco);
      await db.execute(_sqlPassageiro);
    });
    _database = database;
    return database;
  }
}
