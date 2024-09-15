import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/controller/review_controller.dart';
import 'package:crud/MVC/model/meal.dart';
import 'package:crud/MVC/model/review.dart';
import 'package:crud/MVC/view/NavigationBar/appbar.dart';
import 'package:crud/MVC/view/NavigationBar/drawer.dart';
import 'package:crud/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class FoodDetailPage extends StatefulWidget {
  final Meal meal;

  const FoodDetailPage({required this.meal, Key? key}) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  bool isLoggedIn = false;
  late Meal meal;
  List<Map<String, dynamic>> reviewsList = [];
  final ReviewController reviewController = ReviewController();
  String? _userId;

  @override
  void initState() {
    super.initState();
    meal = widget.meal;
    getReviews();
    getUserrId();
  }

  Future<void> getUserrId() async {
    var id = await UserController().getUserId();
    setState(() {
      _userId = id;
    });
  }

  Future<void> getReviews() async {
    try {
      var reviews = await reviewController.getReviewsByMealId(meal.id);
      if (reviews != null) {
        setState(() {
          reviewsList = reviews;
        });
      }
    } catch (e) {
      print("Error fetching reviews: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn = Provider.of<UserController>(context).currentUser != null;

    return Scaffold(
      appBar: AppBarr(isLoggedIn: isLoggedIn),
      drawer: const Drawerr(
        selectedIndex: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    fixedSize: const Size(300, 40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, size: 24, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        LocaleData.back.getString(context),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<String>(
                    valueListenable: isEnglishNotifier,
                    builder: (context, value, child) {
                      String _name;
                      String _type;
                      if (value == "en") {
                        _name = widget.meal.name;
                        _type = widget.meal.type;
                      } else {
                        _name = widget.meal.de_name;
                        _type = widget.meal.de_type;
                      }
                      return Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                _name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              const SizedBox(height: 10),
                              meal.imageUrl.isNotEmpty
                                  ? Image.network(
                                      meal.imageUrl,
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    )
                                  : const Text("Kein Bild verfügbar"),
                              const SizedBox(height: 20),
                              Text(
                                '${widget.meal.price.toStringAsFixed(2)}€',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _type,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          LocaleData.reviewLabel.getString(context),
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        reviewsList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: reviewsList.length,
                                itemBuilder: (context, index) {
                                  final review = reviewsList[index];
                                  return Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 12.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          review["imageUrl"] != null &&
                                                  review["imageUrl"].isNotEmpty
                                              ? Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Image.network(
                                                    review["imageUrl"],
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(
                                                          Icons.error,
                                                          size: 100);
                                                    },
                                                  ),
                                                )
                                              : const Icon(Icons.image,
                                                  size: 120),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  review["review"],
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      initialRating:
                                                          review["stars"]
                                                              .toDouble(),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 28,
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                      ignoreGestures: true,
                                                    ),
                                                  ],
                                                ),
                                                if (_userId ==
                                                    "66e0146c3a1b06783624")
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () async {
                                                      await ReviewController()
                                                          .deleteReview(
                                                              review["id"]);
                                                      await getReviews();
                                                    },
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Text(LocaleData.noReviewsYet.getString(context)),
                        const SizedBox(height: 20),
                        _userId == "66e0146c3a1b06783624" ||
                                _userId == "66e02172f03c0e7efb4c"
                            ? ElevatedButton(
                                onPressed: () {
                                  _showAddReviewDialog();
                                },
                                child: Text(
                                    LocaleData.addReview.getString(context)),
                              )
                            : Text(
                                LocaleData.loginToAddReview.getString(context)),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddReviewDialog() async {
    final _reviewController = TextEditingController();
    double _stars = 5.0;
    String? _imageUrl;
    bool isUploading = false;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(LocaleData.addAReview.getString(context)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _reviewController,
                    decoration: InputDecoration(
                        labelText: LocaleData.review.getString(context)),
                  ),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _stars = rating;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: isUploading
                        ? null
                        : () async {
                            setState(() {
                              isUploading = true;
                            });

                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            if (pickedFile != null) {
                              String filePath = pickedFile.path;

                              String? fileId = await reviewController
                                  .uploadReviewImage(filePath);
                              if (fileId != null) {
                                _imageUrl =
                                    reviewController.getReviewImageUrl(fileId);
                              } else {
                                print('Error uploading image.');
                              }
                            }

                            setState(() {
                              isUploading = false;
                            });
                          },
                    child: Text(LocaleData.takePhoto.getString(context)),
                  ),
                  if (isUploading) const CircularProgressIndicator(),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(LocaleData.cancel.getString(context)),
                ),
                ElevatedButton(
                  onPressed: (!isUploading)
                      ? () async {
                          if (_reviewController.text.isNotEmpty) {
                            String newReviewId = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            final newReview = Review(
                              id: newReviewId,
                              review: _reviewController.text,
                              stars: _stars,
                              imageUrl: _imageUrl ?? '',
                              mealId: meal.id,
                            );
                            await reviewController.createReview(newReview);
                            await getReviews();
                            Navigator.of(context).pop();
                          }
                        }
                      : null,
                  child: Text(LocaleData.submit.getString(context)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
