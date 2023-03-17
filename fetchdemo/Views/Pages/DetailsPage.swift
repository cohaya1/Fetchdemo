//
//  DetailsPage.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import SwiftUI

struct DetailsPage: View {
    @State private var meal: RecipeMealsDetailsResponse?
        @State private var ingredients: [Ingredient] = []
        let mealID: Int
        
        var body: some View {
            VStack {
                if let meal = meal {
                    Text(meal.name)
                        .font(.system(size: 32))
                        .padding(.bottom)
                    
                    Text("Instructions")
                        .font(.system(size: 24))
                        .padding(.bottom)
                    ScrollView {
                        Text(meal.instructions)
                            .font(.system(size: 18))
                            .padding(.bottom)
                            .multilineTextAlignment(.center)
                    }
                    Text("Ingredients")
                        .font(.system(size: 24))
                        .padding(.bottom)
                    
                    List(ingredients, id: \.name) { ingredient in
                        HStack {
                            Text(ingredient.name)
                                .font(.system(size: 18))
                            Spacer()
                            Text(ingredient.quantity)
                                .font(.system(size: 18))
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .task {
                await loadMealDetails(for: mealID)
            }
        }
        
        private func loadMealDetails(for mealID: Int) async {
            do {
                let mealDetail = try await FetchViewModel().getRecipesService(id: mealID
                )
                meal = mealDetail
                ingredients = mealDetail.ingredients
            } catch {
                print("Error fetching meal details: \(error)")
            }
        }
    }

struct DetailsPage_Previews: PreviewProvider {
    static var previews: some View {
       

        DetailsPage(mealID: 1)
            .previewInterfaceOrientation(.portrait)
    }
}
