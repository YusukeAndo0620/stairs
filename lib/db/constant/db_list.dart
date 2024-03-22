import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';

final defaultDbList = [
  // DB
  const TDbCompanion(
    dbId: Value("4e4fe560-261b-43e3-a282-29d1d6c95c96"),
    name: Value("Oracle"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("2e958e3c-f14b-4a38-aa8b-eb53f1a6df27"),
    name: Value("MySQL"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("53a55ae4-2d9a-4b94-a4ef-0adbc9cf0619"),
    name: Value("PostgreSQL"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("8a446d66-9b1d-4872-baf7-8e8212a4104b"),
    name: Value("Microsoft SQL Server"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("8b446d66-9b1d-4872-baf7-8e8212a4104b"),
    name: Value("Microsoft Access"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("8c446d66-9b1d-4872-baf7-8e8212a4104b"),
    name: Value("SQLite"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("8d446d66-9b1d-4872-baf7-8e8212a4104b"),
    name: Value("H2DB"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("71517371-b553-4579-9a4d-075585431b03"),
    name: Value("FileMaker"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("72517371-b553-4579-9a4d-075585431b03"),
    name: Value("Amazon Aurora"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("73517371-b553-4579-9a4d-075585431b03"),
    name: Value("MongoDB"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("74517371-b553-4579-9a4d-075585431b03"),
    name: Value("HBase"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("75517371-b553-4579-9a4d-075585431b03"),
    name: Value("Cassandra"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("76517371-b553-4579-9a4d-075585431b03"),
    name: Value("Amazon Dynamo DB"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("77517371-b553-4579-9a4d-075585431b03"),
    name: Value("Amazon ElastiCache"),
    accountId: Value("1"),
  ),
  // ORM
  const TDbCompanion(
    dbId: Value("78517371-b553-4579-9a4d-075585431b03"),
    name: Value("MyBatis"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("79517371-b553-4579-9a4d-075585431b03"),
    name: Value("Spring JDBC"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("80517371-b553-4579-9a4d-075585431b03"),
    name: Value("Apache Commons DbUtils"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("81517371-b553-4579-9a4d-075585431b03"),
    name: Value("JPA"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("90517371-b553-4579-9a4d-075585431b03"),
    name: Value("Hibernate"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("82517371-b553-4579-9a4d-075585431b03"),
    name: Value("Doctrine"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("83517371-b553-4579-9a4d-075585431b03"),
    name: Value("Eloquent"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("84517371-b553-4579-9a4d-075585431b03"),
    name: Value("idiorm"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("85517371-b553-4579-9a4d-075585431b03"),
    name: Value("SQLAlchemy"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("86517371-b553-4579-9a4d-075585431b03"),
    name: Value("Storm"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("87517371-b553-4579-9a4d-075585431b03"),
    name: Value("Peewee"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("88517371-b553-4579-9a4d-075585431b03"),
    name: Value("Django's ORM"),
    accountId: Value("1"),
  ),
  const TDbCompanion(
    dbId: Value("89517371-b553-4579-9a4d-075585431b03"),
    name: Value("Ruby on Rails ActiveRecord"),
    accountId: Value("1"),
  ),
];
