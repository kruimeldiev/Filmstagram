import { Component, OnInit, Input } from '@angular/core';
import { FetchReview } from 'src/app/models/Review';

import { Router, ActivatedRoute } from '@angular/router';
import { ReviewsService } from 'src/app/services/reviews.service';

@Component({
  selector: 'app-read-review',
  templateUrl: './read-review.component.html',
  styleUrls: ['./read-review.component.css']
})

export class ReadReviewComponent implements OnInit {

  review$: FetchReview;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private reviewsService: ReviewsService) { }

  ngOnInit(): void {
    const reviewUid = this.route.snapshot.paramMap.get('uid');
    if (reviewUid) {
      this.reviewsService.getSingleReview(reviewUid).subscribe((review) => {
        this.review$ = review
      });
    }
  }

  routeBack() {
    return this.router.navigate(['/reviewsOverview']);
  }
}
