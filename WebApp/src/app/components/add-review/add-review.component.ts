import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { PostReview } from '../../models/Review';
import { UiService } from 'src/app/services/ui.service';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-add-review',
  templateUrl: './add-review.component.html',
  styleUrls: ['./add-review.component.css']
})

export class AddReviewComponent implements OnInit {

  @Output() onPostReview: EventEmitter<PostReview> = new EventEmitter();

  reviewTitle: string;
  filmTitle: string;
  filmDirector: string;
  reviewText: string;
  username$: string;

  // Indicates if we want to display the new review form
  // We display/hide the form via the component's HTML using *ngIf
  showAddReview: boolean;

  uiSubscription: Subscription;
  userSubscription: Subscription;

  constructor(
    private uiService: UiService,
    private authService: AuthService) {
    // Same as the header component constructor
    this.uiSubscription = this.uiService.onAddReviewToggle().subscribe(value => this.showAddReview = value);
    // The userSubscription listnes for the logged in user object in authService
    this.userSubscription = this.authService.loggedInUser$.subscribe((user) => {
      if (user) {
        this.username$ = user.username
      }
    });
   }

  ngOnInit(): void { }

  async onSubmit() {

    // Make sure all the fields have an input
    if(!this.filmTitle ||
       !this.reviewTitle ||
       !this.filmDirector ||
       !this.reviewText ||
       !this.username$) {
          alert('Fill in all the fields before posting.');
          return;
    }
    
    // Create the Review object
    const newReview: PostReview = {
      title: this.reviewTitle,
      filmTitle: this.filmTitle,
      filmDirector: this.filmDirector,
      reviewText: this.reviewText,
      authorName: this.username$
    }
    // Emit the review
    this.onPostReview.emit(newReview);
    // Clear the form
    this.reviewTitle = '';
    this.filmTitle = '';
    this.filmDirector = '';
    this.reviewText = '';
  }
}
