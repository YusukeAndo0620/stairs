/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 74 (37 per locale)
///
/// Built on 2024-03-26 at 07:04 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	ja(languageCode: 'ja', build: _StringsJa.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsCommonEn common = _StringsCommonEn._(_root);
	late final _StringsProjectEn project = _StringsProjectEn._(_root);
	late final _StringsBoardEn board = _StringsBoardEn._(_root);
	late final _StringsTaskEn task = _StringsTaskEn._(_root);
	late final _StringsStatusEn status = _StringsStatusEn._(_root);
	late final _StringsResumeEn resume = _StringsResumeEn._(_root);
}

// Path: common
class _StringsCommonEn {
	_StringsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get add => 'add';
	String addWithTitle({required Object title}) => '${title}を追加';
	String emptyWithTitle({required Object title}) => '${title}が登録されていません。\n${title}を追加してください。';
	String hintWithTitle({required Object title}) => '${title}を設定';
	String inputWithTitle({required Object title}) => '${title}を入力';
	String get completed => 'completed';
	String get cancel => 'cancel';
	String get color => 'Color';
	String get colorHint => 'setting main theme';
	String get role => '役割';
	String get roleHint => 'プロジェクトにおける役割を設定';
	String get os => 'OS';
	String get db => 'DB・ORM';
	String get devLang => '開発言語';
	String get devLangHint => '開発言語、フレームワークを設定';
	String get devLangVersionHint => 'バージョンなどを入力してください。表示例: Java(Java8)';
	String get git => 'Git';
	String get mw => 'ミドルウェア';
	String get tool => '開発ツール';
	String get toolHint => 'ツールを設定（Backlog, Figmaなど）';
	String get workProgress => '作業工程';
	String get label => 'Label';
}

// Path: project
class _StringsProjectEn {
	_StringsProjectEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Project Name';
	String get list => 'Project List';
	String get projectEmpty => '表示可能なボードがありません。\nボードを作成してください。';
	String get industry => '業種';
	String get devMethod => '開発手法';
	String get period => '期間';
	String get workContent => '業務内容';
	String get devSize => '開発人数';
	String get displaySize => '画面数';
	String get tableCount => 'テーブル数';
}

// Path: board
class _StringsBoardEn {
	_StringsBoardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'ボード';
	String get workBoard => 'ワークボード';
}

// Path: task
class _StringsTaskEn {
	_StringsTaskEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'タスク';
}

// Path: status
class _StringsStatusEn {
	_StringsStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'ステータス';
}

// Path: resume
class _StringsResumeEn {
	_StringsResumeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => '経歴書';
}

// Path: <root>
class _StringsJa implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsJa.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsJa _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonJa common = _StringsCommonJa._(_root);
	@override late final _StringsProjectJa project = _StringsProjectJa._(_root);
	@override late final _StringsBoardJa board = _StringsBoardJa._(_root);
	@override late final _StringsTaskJa task = _StringsTaskJa._(_root);
	@override late final _StringsStatusJa status = _StringsStatusJa._(_root);
	@override late final _StringsResumeJa resume = _StringsResumeJa._(_root);
}

// Path: common
class _StringsCommonJa implements _StringsCommonEn {
	_StringsCommonJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String addWithTitle({required Object title}) => '${title}を追加';
	@override String emptyWithTitle({required Object title}) => '${title}が登録されていません。\n${title}を追加してください。';
	@override String hintWithTitle({required Object title}) => '${title}を設定';
	@override String inputWithTitle({required Object title}) => '${title}を入力';
	@override String get add => '追加';
	@override String get completed => '完了';
	@override String get cancel => 'キャンセル';
	@override String get color => '色';
	@override String get colorHint => 'メインテーマを設定';
	@override String get role => '役割';
	@override String get roleHint => 'プロジェクトにおける役割を設定';
	@override String get os => 'OS';
	@override String get db => 'DB・ORM';
	@override String get devLang => '開発言語';
	@override String get devLangHint => '開発言語、フレームワークを設定';
	@override String get devLangVersionHint => 'バージョンなどを入力してください。表示例: Java(Java8)';
	@override String get git => 'Git';
	@override String get mw => 'ミドルウェア';
	@override String get tool => '開発ツール';
	@override String get toolHint => 'ツールを設定（Backlog, Figmaなど）';
	@override String get workProgress => '作業工程';
	@override String get label => 'ラベル';
}

// Path: project
class _StringsProjectJa implements _StringsProjectEn {
	_StringsProjectJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get name => 'プロジェクト名';
	@override String get list => 'プロジェクト一覧';
	@override String get projectEmpty => '表示可能なボードがありません。\nボードを作成してください。';
	@override String get industry => '業種';
	@override String get devMethod => '開発手法';
	@override String get period => '期間';
	@override String get workContent => '業務内容';
	@override String get devSize => '開発人数';
	@override String get displaySize => '画面数';
	@override String get tableCount => 'テーブル数';
}

// Path: board
class _StringsBoardJa implements _StringsBoardEn {
	_StringsBoardJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get name => 'ボード';
	@override String get workBoard => 'ワークボード';
}

// Path: task
class _StringsTaskJa implements _StringsTaskEn {
	_StringsTaskJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get name => 'タスク';
}

// Path: status
class _StringsStatusJa implements _StringsStatusEn {
	_StringsStatusJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get name => 'ステータス';
}

// Path: resume
class _StringsResumeJa implements _StringsResumeEn {
	_StringsResumeJa._(this._root);

	@override final _StringsJa _root; // ignore: unused_field

	// Translations
	@override String get name => '経歴書';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.add': return 'add';
			case 'common.addWithTitle': return ({required Object title}) => '${title}を追加';
			case 'common.emptyWithTitle': return ({required Object title}) => '${title}が登録されていません。\n${title}を追加してください。';
			case 'common.hintWithTitle': return ({required Object title}) => '${title}を設定';
			case 'common.inputWithTitle': return ({required Object title}) => '${title}を入力';
			case 'common.completed': return 'completed';
			case 'common.cancel': return 'cancel';
			case 'common.color': return 'Color';
			case 'common.colorHint': return 'setting main theme';
			case 'common.role': return '役割';
			case 'common.roleHint': return 'プロジェクトにおける役割を設定';
			case 'common.os': return 'OS';
			case 'common.db': return 'DB・ORM';
			case 'common.devLang': return '開発言語';
			case 'common.devLangHint': return '開発言語、フレームワークを設定';
			case 'common.devLangVersionHint': return 'バージョンなどを入力してください。表示例: Java(Java8)';
			case 'common.git': return 'Git';
			case 'common.mw': return 'ミドルウェア';
			case 'common.tool': return '開発ツール';
			case 'common.toolHint': return 'ツールを設定（Backlog, Figmaなど）';
			case 'common.workProgress': return '作業工程';
			case 'common.label': return 'Label';
			case 'project.name': return 'Project Name';
			case 'project.list': return 'Project List';
			case 'project.projectEmpty': return '表示可能なボードがありません。\nボードを作成してください。';
			case 'project.industry': return '業種';
			case 'project.devMethod': return '開発手法';
			case 'project.period': return '期間';
			case 'project.workContent': return '業務内容';
			case 'project.devSize': return '開発人数';
			case 'project.displaySize': return '画面数';
			case 'project.tableCount': return 'テーブル数';
			case 'board.name': return 'ボード';
			case 'board.workBoard': return 'ワークボード';
			case 'task.name': return 'タスク';
			case 'status.name': return 'ステータス';
			case 'resume.name': return '経歴書';
			default: return null;
		}
	}
}

extension on _StringsJa {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'common.addWithTitle': return ({required Object title}) => '${title}を追加';
			case 'common.emptyWithTitle': return ({required Object title}) => '${title}が登録されていません。\n${title}を追加してください。';
			case 'common.hintWithTitle': return ({required Object title}) => '${title}を設定';
			case 'common.inputWithTitle': return ({required Object title}) => '${title}を入力';
			case 'common.add': return '追加';
			case 'common.completed': return '完了';
			case 'common.cancel': return 'キャンセル';
			case 'common.color': return '色';
			case 'common.colorHint': return 'メインテーマを設定';
			case 'common.role': return '役割';
			case 'common.roleHint': return 'プロジェクトにおける役割を設定';
			case 'common.os': return 'OS';
			case 'common.db': return 'DB・ORM';
			case 'common.devLang': return '開発言語';
			case 'common.devLangHint': return '開発言語、フレームワークを設定';
			case 'common.devLangVersionHint': return 'バージョンなどを入力してください。表示例: Java(Java8)';
			case 'common.git': return 'Git';
			case 'common.mw': return 'ミドルウェア';
			case 'common.tool': return '開発ツール';
			case 'common.toolHint': return 'ツールを設定（Backlog, Figmaなど）';
			case 'common.workProgress': return '作業工程';
			case 'common.label': return 'ラベル';
			case 'project.name': return 'プロジェクト名';
			case 'project.list': return 'プロジェクト一覧';
			case 'project.projectEmpty': return '表示可能なボードがありません。\nボードを作成してください。';
			case 'project.industry': return '業種';
			case 'project.devMethod': return '開発手法';
			case 'project.period': return '期間';
			case 'project.workContent': return '業務内容';
			case 'project.devSize': return '開発人数';
			case 'project.displaySize': return '画面数';
			case 'project.tableCount': return 'テーブル数';
			case 'board.name': return 'ボード';
			case 'board.workBoard': return 'ワークボード';
			case 'task.name': return 'タスク';
			case 'status.name': return 'ステータス';
			case 'resume.name': return '経歴書';
			default: return null;
		}
	}
}
