import { Component, OnInit } from '@angular/core';
import { FetchReview, PostReview } from 'src/app/models/Review';
import { ReviewsService } from 'src/app/services/reviews.service';

@Component({
  selector: 'app-reviews',
  templateUrl: './reviews.component.html',
  styleUrls: ['./reviews.component.css']
})

/// This reviews component is like the parent class for all the reviews we want to display
/// In Swift terms this would be like a custom List object that shows the reviews
export class ReviewsComponent implements OnInit {
  
  /// This array representes the reviews that we want to display
  reviews: FetchReview[] = [];

  /// This constructor acts like an initializer
  constructor(private reviewsService: ReviewsService) { }

  /// During this init we can fill our reviews array with the reviews we fetch from the ReviewsService
  ngOnInit(): void {
    this.fetchAllReviews()
  }

  /// getReviews() is an asyncronous function, this means that we have to subscribe to the result so that we can update the data if needed
  fetchAllReviews() {
    this.reviewsService.getReviews().subscribe((reviews) => (this.reviews = reviews));

    // TODO: Remove
    console.log(this.reviews)
  }

  // Called via EventEmitter from the add-review component
  postReview(review: PostReview) {
    this.reviewsService.postReview(review).subscribe((review) => {
      console.log(`Review posted: ${review}`)
      this.fetchAllReviews()
    });
  }
}
