/// Modèle générique pour toutes les réponses du backend
/// Format : { success, message, data, pagination? }
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final Pagination? pagination;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.pagination,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromData,
  ) {
    return ApiResponse<T>(
      success:    json['success'] as bool? ?? false,
      message:    json['message'] as String? ?? '',
      data:       json['data'] != null && fromData != null
                    ? fromData(json['data'])
                    : null,
      pagination: json['pagination'] != null
                    ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
                    : null,
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  const Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page:       json['page']       as int? ?? 1,
    limit:      json['limit']      as int? ?? 20,
    total:      json['total']      as int? ?? 0,
    totalPages: json['totalPages'] as int? ?? 1,
    hasNext:    json['hasNext']    as bool? ?? false,
    hasPrev:    json['hasPrev']    as bool? ?? false,
  );
}
