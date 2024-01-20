enum PlanType {
  free("0"),
  standard("1");

  final String planValue;
  const PlanType(this.planValue);
}

// 値からPlanTypeを取得
PlanType getPlanType(String value) =>
    PlanType.values.firstWhere((e) => e.planValue == value);

class AccountModel {
  AccountModel({
    required this.accountId,
    required this.address,
    required this.planType,
  });

  final String accountId;
  final String address;
  final PlanType planType;

  factory AccountModel.fromJson(dynamic json) {
    final accountId = json['account_id'];
    final address = json['address'];
    final planType = getPlanType(json['plan_type']);

    final model = AccountModel(
      accountId: accountId,
      address: address,
      planType: planType,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['account_id'] = accountId;
    data['address'] = address;
    data['plan_type'] = planType.planValue;

    return data;
  }

  @override
  String toString() {
    return 'AccountModel{account_id: $accountId, address: $address, plan_type: ${planType.planValue}}';
  }
}
