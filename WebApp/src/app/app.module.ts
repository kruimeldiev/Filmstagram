import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { RouterModule, Routes } from '@angular/router';

import { HeaderComponent } from './components/header/header.component';
import { ButtonComponent } from './components/button/button.component';
import { ReviewsComponent } from './components/reviews/reviews.component';
import { ReviewItemComponent } from './components/review-item/review-item.component';
import { AddReviewComponent } from './components/add-review/add-review.component';
import { LoginComponent } from './components/login/login.component';
import { ReadReviewComponent } from './components/read-review/read-review.component';

import { environment } from '../environments/environment';
import { provideAuth, getAuth } from '@angular/fire/auth';
import { AngularFireModule } from '@angular/fire/compat';
import { AuthGuard } from './services/auth.guard';
import { RegisterComponent } from './components/register/register.component';

// Array that contains all the routes in the app
const appRoutes: Routes = [
  // Index (home) which contains the login screen
  { path: '', component: LoginComponent },
  // Register user
  { path: 'register', component: RegisterComponent },
  // Reviews component
  { path: 'reviewsOverview', component: ReviewsComponent, canActivate: [AuthGuard] },
  // Open a review
  { path: 'review/:uid', component: ReadReviewComponent, canActivate: [AuthGuard] }
]

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    ButtonComponent,
    ReviewsComponent,
    ReviewItemComponent,
    AddReviewComponent,
    LoginComponent,
    ReadReviewComponent,
    RegisterComponent
  ],
  imports: [
    AngularFireModule.initializeApp(environment.firebase),
    provideAuth(() => getAuth()),
    BrowserModule,
    HttpClientModule,
    FormsModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [],
  bootstrap: [AppComponent]
})

export class AppModule { }
