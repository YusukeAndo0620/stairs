import 'package:drift/drift.dart';
import 'package:stairs/db/database.dart';

final defaultToolList = [
  // IDE
  const TToolCompanion(
    toolId: Value("af3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("VSCode"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("bf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("IntelliJ"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("cf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Eclipse"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("df3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Xcode"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("ef3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Android Studio"),
    accountId: Value("1"),
  ),
  // タスク管理
  const TToolCompanion(
    toolId: Value("ff3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Backlog"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("gf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Redmine"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("hf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Jira"),
    accountId: Value("1"),
  ),
  // テスト用ツール、CI・CD
  const TToolCompanion(
    toolId: Value("if3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Jmeter"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("jf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Artillery"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("kf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Jenkins"),
    accountId: Value("1"),
  ),
  // UI・ドキュメント生成系
  const TToolCompanion(
    toolId: Value("lf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Figma"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("mf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Confluence"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("nf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("PlantUML"),
    accountId: Value("1"),
  ),
  // その他ツール
  const TToolCompanion(
    toolId: Value("of3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("A5"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("pf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Miro"),
    accountId: Value("1"),
  ),
  // チャットツール
  const TToolCompanion(
    toolId: Value("qf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Slack"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("rf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Teams"),
    accountId: Value("1"),
  ),
  const TToolCompanion(
    toolId: Value("sf3e19d3-52c2-49fc-9c23-a5b250872329"),
    name: Value("Google Chat"),
    accountId: Value("1"),
  ),
];
