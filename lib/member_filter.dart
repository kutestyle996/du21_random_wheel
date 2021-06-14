import 'dart:convert';

class MemberFilter {
  final String name;
  final bool isSelected;


  MemberFilter({required this.name, required this.isSelected});

  factory MemberFilter.fromJson(Map<String, dynamic> jsonData) {
    return MemberFilter(
      name: jsonData['name'],
      isSelected: jsonData['isSelected']
    );
  }

  static Map<String, dynamic> toMap(MemberFilter member) => {
    'name': member.name,
    'isSelected': member.isSelected
  };

  static String encode(List<MemberFilter> members) => json.encode(
    members
        .map<Map<String, dynamic>>((member) => MemberFilter.toMap(member))
        .toList(),
  );

  static List<MemberFilter> decode(String members) =>
      (json.decode(members) as List<dynamic>)
          .map<MemberFilter>((item) => MemberFilter.fromJson(item))
          .toList();
}