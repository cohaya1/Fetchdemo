//
//  MealTableListItem.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//


import SwiftUI

struct MealTableListItem: View {
    @State var mealLists: DessertListsModelResponse

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(width: 220, height: 270)
                .shadow(color: Color.black.opacity(0.1), radius: 60, x: 0, y: 30)

            ZStack {
                Circle()
                    .fill(Color(white: 0.95))

                Circle()
                    .strokeBorder(Color(white: 0.95), lineWidth: 1)

                if let url = URL(string: mealLists.image) {
                    CacheAsyncImage(url: url) { result in
                        switch result {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 276.1, height: 183.1)
                                .clipped()
                        case .failure(let error):
                            // Handle error
                            Text(error.localizedDescription)
                        @unknown default:
                            fatalError()
                        }
                    }
                }
            }
            .compositingGroup()
            .frame(width: 164.2, height: 174.2)
            .shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 4)
            .padding(.bottom, 200)

            VStack(spacing: 25) {
                Text(mealLists.name)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(width: 220, height: 70, alignment: .center)
                    .foregroundColor(Color.black)
            }
            .padding(.top, 100)
        }
    }
}

struct MealTableListsItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MealTableListItem(mealLists: DessertListsModelResponse(name: "Food", image: "Unknown", id: 1))
        }
    }
}
