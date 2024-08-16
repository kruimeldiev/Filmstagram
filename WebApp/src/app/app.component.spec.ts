import { TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { AppComponent } from './app.component';
import { AddReviewComponent } from './components/add-review/add-review.component';
import { ButtonComponent } from './components/button/button.component';
import { HeaderComponent } from './components/header/header.component';
import { LoginComponent } from './components/login/login.component';
import { ReadReviewComponent } from './components/read-review/read-review.component';
import { RegisterComponent } from './components/register/register.component';
import { ReviewItemComponent } from './components/review-item/review-item.component';
import { ReviewsComponent } from './components/reviews/reviews.component';

describe('AppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [
        RouterTestingModule,
      ],
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
    }).compileComponents();
  });

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  // it('should render title', () => {
  //   const fixture = TestBed.createComponent(AppComponent);
  //   fixture.detectChanges();
  //   const compiled = fixture.nativeElement as HTMLElement;
  //   expect(compiled.querySelector('.content span')?.textContent).toContain('Login');
  // });
});
