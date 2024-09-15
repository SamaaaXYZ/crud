import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:crud/MVC/model/review.dart';

class ReviewController {
  final Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("66d21c6d003b3e4fc841");

  Future<String?> uploadReviewImage(String filePath) async {
    try {
      final storage = Storage(client);

      models.File uploadedFile = await storage.createFile(
        bucketId: '66da1d2e000fac3be388',
        fileId: ID.unique(),
        file: InputFile(path: filePath),
        permissions: [
          Permission.read(Role.any()),
        ],
      );

      return uploadedFile.$id;
    } on AppwriteException catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  String getReviewImageUrl(String fileId) {
    return 'https://cloud.appwrite.io/v1/storage/buckets/66da1d2e000fac3be388/files/$fileId/view?project=66d21c6d003b3e4fc841';
  }

  Future<void> createReview(Review review) async {
    try {
      final databases = Databases(client);
      String reviewId = review.id;

      await databases.createDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d574230020df8d38c5",
        documentId: ID.custom(reviewId),
        data: review.doc(),
      );
      print('Review created successfully with image URL: ${review.imageUrl}');
    } on AppwriteException catch (e) {
      print("Error creating review: $e");
    }
  }

  Future<List<Map<String, dynamic>>?> getReviewsByMealId(String mealId) async {
    try {
      final databases = Databases(client);
      final response = await databases.listDocuments(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d574230020df8d38c5",
        queries: [
          Query.equal('mealId', mealId),
        ],
      );

      List<Map<String, dynamic>> reviews = [];
      for (var doc in response.documents) {
        reviews.add({
          "id": doc.$id,
          "review": doc.data["review"],
          "stars": doc.data["stars"],
          "imageUrl": doc.data["imageUrl"],
        });
      }
      return reviews;
    } on AppwriteException catch (e) {
      print("Error fetching reviews for meal $mealId: $e");
      return null;
    }
  }

  Future<void> updateReview(String id, String review, double stars) async {
    try {
      final databases = Databases(client);

      await databases.updateDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d574230020df8d38c5",
        documentId: ID.custom(id),
        data: {
          "review": review,
          "stars": stars,
        },
      );
    } on AppwriteException catch (e) {
      print('Failed to update review: ${e.message}, ${e.code}, ${e.response}');
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      final databases = Databases(client);

      await databases.deleteDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d574230020df8d38c5",
        documentId: reviewId,
      );
    } on AppwriteException catch (e) {
      print("Error deleting review: $e");
    }
  }

  Future<List<dynamic>?> showReview(String reviewId) async {
    try {
      final databases = Databases(client);
      final document = await databases.getDocument(
        databaseId: "66d21c940032616f4ce7",
        collectionId: "66d574230020df8d38c5",
        documentId: reviewId,
      );

      List<dynamic> reviewData = [
        document.$id,
        document.data["review"],
        document.data["stars"],
        document.data["imageUrl"],
      ];

      return reviewData;
    } on AppwriteException catch (e) {
      print("Error fetching review: $e");
    }
    return null;
  }
}
