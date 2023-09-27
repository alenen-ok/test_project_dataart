class UserEntity {
  int id = 0;
  final String login;
  final String hashPassword;

  UserEntity({required this.login, required this.hashPassword});

  static const String tableName = "users";
  static const String columnId = "id";
  static const String columnLogin = "login";
  static const String columnPassword = "password";

  Map<String, dynamic> toMap() => {
        columnLogin: login,
        columnPassword: hashPassword,
      };

  UserEntity.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        login = map[columnLogin],
        hashPassword = map[columnPassword];

  static List<UserEntity> fromMapList(List<dynamic> maps) => maps.map((i) => UserEntity.fromMap(i)).toList();

  static String create() => """
  CREATE TABLE $tableName ( 
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnLogin TEXT NOT NULL, 
      $columnPassword TEXT NOT NULL
    )""";
}
