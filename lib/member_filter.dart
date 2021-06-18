import 'dart:convert';

class MemberFilter {
  final String id;
  final String name;
  final bool isSelected;


  MemberFilter({required this.name, required this.isSelected, required this.id});

  factory MemberFilter.fromJson(Map<String, dynamic> jsonData) {
    return MemberFilter(
      id: jsonData['id'],
      name: jsonData['name'],
      isSelected: jsonData['isSelected']
    );
  }

  static Map<String, dynamic> toMap(MemberFilter member) => {
    'id' : member.id,
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