import { Component, OnInit, Input } from '@angular/core';
import { FetchReview } from 'src/app/models/Review';
import { Router } from '@angular/router';

@Component({
  selector: 'app-review-item',
  templateUrl: './review-item.component.html',
  styleUrls: ['./review-item.component.css']
})

export class ReviewItemComponent implements OnInit {

  @Input() review: FetchReview;

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  reviewSelected(review: FetchReview) {
    this.router.navigate(['/review/', this.review.uid]);
  }
}
