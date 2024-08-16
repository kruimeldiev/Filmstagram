import { HttpClientModule } from '@angular/common/http';
import { TestBed } from '@angular/core/testing';

import { AngularFireModule } from "@angular/fire/compat";

import { AuthService } from './auth.service';

describe('AuthService', () => {
  let service: AuthService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [
        AngularFireModule,
        HttpClientModule
      ]
    })
    .compileComponents();
    service = TestBed.inject(AuthService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
