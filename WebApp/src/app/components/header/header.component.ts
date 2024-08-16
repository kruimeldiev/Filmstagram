import { Component, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';
import { UiService } from 'src/app/services/ui.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})

export class HeaderComponent implements OnInit {

  // We can add properties here that can be used throughout the component
  headerTitle: string = 'Filmstagram';

  showAddReview: boolean;
  subscription: Subscription;

  // constructor() and ngOnInit() are lifecycle methods
  constructor(private uiService: UiService, 
              private router: Router,
              private authService: AuthService) {
    // Subscribe to the uiService to activate the observable
    // The showAddReview property from this class then changes to the value from uiService via the arrow function
    this.subscription = this.uiService.onAddReviewToggle().subscribe(value => this.showAddReview = value)
   }

  // Functions to run when the component (header in this case) loads, should be places in here
  ngOnInit(): void { }

  toggleNewReview() {
    this.uiService.toggleAddReview();
  }

  // This function makes sure that the 'Add review' button is only displayed on the Reviews overview page
  // In the header's HTML we set an ngIf that indicates if the url is the same as the Reviews component url
  hasRoute(route: string) {
    return this.router.url === route;
  }

  logoutUser() {
    this.authService.signOutUser();
  }

  routeToRegister() {
    return this.router.navigate(['/register']);
  }

  routeBack() {
    return this.router.navigate(['/']);
  }
}
