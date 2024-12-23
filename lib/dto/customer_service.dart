class CustomerService {
  final int idCustomerService;
  final String titleIssues;
  final String descriptionIssues;
  final int rating;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  CustomerService({
    required this.idCustomerService,
    required this.titleIssues,
    required this.descriptionIssues,
    required this.rating,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory CustomerService.fromJson(Map<String, dynamic> json) {
    return CustomerService(
      idCustomerService: json['id_customer_service'] as int,
      titleIssues: json['title_issues'] as String,
      descriptionIssues: json['description_issues'] as String,
      rating: json['rating'] as int,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }
}
