//
//  HomePage.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import SwiftUI

struct HomePage: View {
    @State private var desserts: [DessertListsModelResponse] = []
    @State private var mealDetail: RecipeMealsDetailsResponse?
    @StateObject private var viewModel = FetchViewModel()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.949999988079071, green: 0.949999988079071, blue: 0.949999988079071, alpha: 1)))
                    .frame(width: 464, height: 956)
                
                VStack(spacing:55){
                    delicioustext
                    
                    
                    
                }.padding(.bottom,400)
                
                LazyVStack() {
                    
                    
                    ScrollView(Axis.Set.horizontal,showsIndicators: false) {
                        LazyHStack(spacing:45){
                            ForEach(desserts, id:\.id) { dessert in
                                NavigationLink(destination: DetailsPage(mealID: dessert.id)) {
                                    MealTableListItem(mealLists: dessert)
                                }
                                
                            }
                        }
                        .task {
                            do {
                                desserts = try await viewModel.getAllDessertsService(for: .dessert)
                            } catch {
                                print(StatusCodes.failure.localizedDescription)
                            }
                        }
                        
                        
                    }.background(Color(#colorLiteral(red: 0.949999988079071, green: 0.949999988079071, blue: 0.949999988079071, alpha: 1)))
                        .frame( height: 400)
                        .padding(.top,-2)
                    
                    
                }.padding(.top,430)
                   
            }
            .navigationBarHidden(true)
        }.navigationBarHidden(true)
        
    }
    
     var delicioustext: some View {
        Text("Delicious \nfood for you").font(.system(size: 34, weight: .bold, design: .rounded))
    }
    
}
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
