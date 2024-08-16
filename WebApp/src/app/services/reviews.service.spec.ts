import { HttpClientModule } from '@angular/common/http';
import { TestBed } from '@angular/core/testing';

import { ReviewsService } from './reviews.service';

describe('ReviewsService', () => {
  let service: ReviewsService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [
        HttpClientModule
      ]
    })
    .compileComponents();
    service = TestBed.inject(ReviewsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
