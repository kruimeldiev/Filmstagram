import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})

export class UiService {

  private showAddReview: boolean = false;
  private subject = new Subject<any>();

  constructor() { }

  // Called whenever the user has clicked on the 'Add review' button via the header component (toggleNewReview())
  toggleAddReview(): void {
    this.showAddReview = !this.showAddReview;
    this.subject.next(this.showAddReview);
  }

  // Called by toggleAddReview()
  onAddReviewToggle(): Observable<any> {
    return this.subject.asObservable();
  }
}
