import 'package:stairs/db/database.dart';
import 'package:drift/drift.dart';

final dummyDevLangList = [
  const MDevLanguageCompanion(
    devLangId: Value('20479587-fddc-480b-a8e5-122190bd04f8'),
    name: Value('Angular'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('9660293d-3818-4e63-9854-db194ee81aed'),
    name: Value('Backbone'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('6889a474-3c5c-407a-b0f0-689608fe0592'),
    name: Value('Blade'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('e286e678-9c32-4a50-85e5-48aeee40f7d7'),
    name: Value('C++'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('ee1042a3-fde1-4ecc-81df-7d909926d4d0'),
    name: Value('C#'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('284e67fd-6e53-4d8a-9391-8c103392779b'),
    name: Value('Clojure'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('d263edbb-308d-421d-a633-3e04db77b3c3'),
    name: Value('CSS'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('842f9797-3615-4fa1-ad34-eef47fa88c81'),
    name: Value('Dart'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('653e339e-190e-4419-ba7b-cc0823eefadd'),
    name: Value('Django'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('b4aaa4a3-e2ae-44ae-8e43-f40234779593'),
    name: Value('Elixir'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('927ce4fc-d610-4d6f-b025-45431527998e'),
    name: Value('Ember'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('98375c8d-d4ec-469e-83c5-fed32df7abf3'),
    name: Value('Express'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('58aa380e-bde2-4b5a-955f-e6848a0a72f3'),
    name: Value('Flask'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('3020294e-4e00-47cd-b90a-b828f773c9ac'),
    name: Value('Flutter'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('c8156f5b-e086-4085-9762-2e6ea75df569'),
    name: Value('Freemarker'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('3bdff153-c42d-44f9-ad58-2f01e3b29906'),
    name: Value('Go'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('36dca736-8667-4d53-a1f5-a75512780e6e'),
    name: Value('Handlebars'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('6b817e90-38d3-4d94-876e-5b7b8f878ecb'),
    name: Value('Haskell'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('14169d52-c172-4411-82cb-9dd9c0985316'),
    name: Value('HTML'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('1e399688-9d4c-4b8e-98d7-6e02af716ab8'),
    name: Value('Java'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('c76c1cfe-6703-4777-ac46-15710f34174f'),
    name: Value('JavaScript'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('76926e3d-4140-4f66-8734-dbeea2c2167a'),
    name: Value('Jade'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('ff355222-d54d-4374-8ef4-f6fcd24bf369'),
    name: Value('JSF'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('a58f2870-2403-4863-ad4a-2126390192e0'),
    name: Value('Kotlin'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('48b2866e-aa02-4160-a203-a1fc92d8a1df'),
    name: Value('Koa'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('539839f8-f3f8-48a8-8fbb-3f4fb993dc52'),
    name: Value('Laravel'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('d66f5e3e-3bab-4452-9987-7a5a9d4d474a'),
    name: Value('Less'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('cffb43e8-e885-4c38-9c15-5675c4778676'),
    name: Value('Lua'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('3b6be98c-7ef4-4a8b-94b9-bea2b0f0611c'),
    name: Value('Mustache'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('eee4157e-26c4-4930-befc-8f5874bd8643'),
    name: Value('Perl'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('2796388d-1eb9-4c87-83d6-e085fbebc4d9'),
    name: Value('PHP'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('3c1c9f07-5059-4673-a281-6b264b4a2ddd'),
    name: Value('Python'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('a0a62f4a-daa7-4972-827a-e43162d12b8d'),
    name: Value('R'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('0e5db70a-3e8c-405b-a27c-37135b60e173'),
    name: Value('Rails'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('8823df6c-589c-4eae-8b14-90197194881a'),
    name: Value('React'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('edea106a-1fb8-468b-999a-cf64e45fbd4b'),
    name: Value('Ruby'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('6ceca2b8-3185-4ec0-8cdf-31eb5e8d4abe'),
    name: Value('Rust'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('264ac31d-45c0-4d38-af4c-907247802aed'),
    name: Value('Sass'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('3b232d0e-5b06-41f8-a3de-3d4c2ddfbe9a'),
    name: Value('Scala'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('9c29b3b1-629d-4b4d-a775-24f82ca1de3e'),
    name: Value('Shell'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('cc38337d-21db-49cf-9506-9c1c54253170'),
    name: Value('Spring'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('46f49ebf-9afb-43c2-9265-d6bb2fb1dcf4'),
    name: Value('Spring Boot'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('08802ef5-a61a-4868-97ef-cb6eeeb620ca'),
    name: Value('Stylus'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('41efc0a2-c01b-448a-a85d-907a15e6ac04'),
    name: Value('Struts'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('19f99137-d2ce-478b-8a16-3c3c37ecca37'),
    name: Value('Swift'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('6e416cfc-18ef-45fa-a5e6-a66c5082efe9'),
    name: Value('Thymeleaf'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('f63b60bb-2dfd-4b5c-b371-f97c16746d85'),
    name: Value('TypeScript'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('7be01229-321d-46a6-8fc6-0e6e2836386b'),
    name: Value('Velocity'),
    isReadOnly: Value(true),
  ),
  const MDevLanguageCompanion(
    devLangId: Value('22ec5cc6-ff95-4d9d-a3f3-b60707dac814'),
    name: Value('Vue'),
    isReadOnly: Value(true),
  )
];
