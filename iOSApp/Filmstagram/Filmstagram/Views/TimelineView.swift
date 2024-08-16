//
//  TimelineView.swift
//  Filmstagram
//
//  Created by Casper on 10/05/2022.
//

import SwiftUI

struct TimelineView: View {
    
    @ObservedObject var viewModel: TimelineViewModel
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0..<viewModel.myTimelineItems.count, id: \.self) { timelineItem in
                        NavigationLink {
                            FilmReviewView(viewModel: .init(filmReview: viewModel.myTimelineItems[timelineItem]))
                        } label: {
                            TimelineCell(review: viewModel.myTimelineItems[timelineItem])
                        }
                    }
                }
                
                /// This HStack represents the + button for new reviews
                HStack() {
                    Spacer()
                    VStack {
                        Spacer()
                        Button {
                            viewModel.showingNewReviewSheet.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(ColorKeys.oceanBlue.rawValue))
                                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 0)
                        }
                        .sheet(isPresented: $viewModel.showingNewReviewSheet) {
                            NewReviewView(viewModel: .init())
                        }
                    }
                }
                .padding(20)
            }
            .navigationTitle("For you")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            Task {
                await viewModel.fetchTimeline()
            }
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView(viewModel: .init())
    }
}
