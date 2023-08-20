import 'dart:convert';
import 'filter_criterion.dart';
import 'sort_criterion.dart';

class QueryCriteria {
  List<SortCriterion>? sort;
  List<FilterCriterion>? filter;

  QueryCriteria({this.filter, this.sort});

  QueryCriteria build(FilterCriterion item) {
    return new QueryCriteria(filter: [item]);
  }

  QueryCriteria buildAnd(List<FilterCriterion> items) {
    return new QueryCriteria(filter: [FilterCriterion(and: items)]);
  }

  String queryCriteriaBase64() {
    String json = jsonEncode(this);
    return base64.encode(utf8.encode(json));
  }

  Map<String, dynamic> toJson() => {
        "sort": sort != null
            ? List<dynamic>.from(sort!.map((x) => x.toJson()).toList())
            : [],
        "filter": filter != null
            ? List<dynamic>.from(filter!.map((x) => x.toJson()).toList())
            : [],
      };
}