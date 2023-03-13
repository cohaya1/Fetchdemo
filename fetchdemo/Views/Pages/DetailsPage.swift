//
//  DetailsPage.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import SwiftUI

struct DetailsPage: View {
    internal let recipe: Recipe
    @StateObject var viewModel = FetchListFetcher(service: NetworkManager())
    var body: some View {
        NavigationView {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(#colorLiteral(red: 0.949999988079071, green: 0.949999988079071, blue: 0.949999988079071, alpha: 1)))
            .frame(width: 464, height: 956)
            HStack(spacing: 260){
                backarrowicon
                
            }.padding(.bottom,700)
            VStack{
                dinnerplate
            }.padding(.bottom,400)
            VStack(spacing: 20) {
                MealName
                mealingredients
            }.task {
                await  viewModel.getRecipes()
            }
            VStack(spacing: 200){
                restaurantdescription
              
            }.padding(.top,400)
            VStack(alignment: .center) {
                Text("Deliver to Me").font(.system(size: 17, weight: .semibold, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.98, green: 0.29, blue: 0.05, alpha: 1))).multilineTextAlignment(.center)
                    .padding(.leading,25)
            }.padding(.top,600)
        }.navigationBarHidden(true)
       
        }.navigationBarHidden(true )
    }
    var backarrowicon: some View {
        NavigationLink(destination: HomePage(), label: {
            Image("backarrowicon")
                .resizable()
                .frame(width: 15, height: 24)
                .scaledToFit()
        })
                       }
   
    var dinnerplate: some View {
        ZStack {
            
            Circle()
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .opacity(0.89)
            

            Circle()
                .strokeBorder(Color(#colorLiteral(red: 0.949999988079071, green: 0.949999988079071, blue: 0.949999988079071, alpha: 0.25)), lineWidth: 1)
            
        }
        .compositingGroup()
        .frame(width: 281.21, height: 251.21)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0,alpha:1)), radius:4, x:0, y:4)
    }
    var MealName: some View {
        //Veggie tomato mix
        Text(recipe.strMeal ?? " ").font(.system(size: 28, weight: .semibold, design: .rounded)).multilineTextAlignment(.center)
    }
    var mealingredients: some View {
        //N1,900
        if let ingredient1 = recipe.strIngredient1,
           let ingredient2 = recipe.strIngredient2 {
            let ingredients = [ingredient1, ingredient2].joined(separator: ", ")
            return Text(ingredients).font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.98, green: 0.29, blue: 0.05, alpha: 1))).multilineTextAlignment(.center)
        } else {
            return Text("Unknown").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.98, green: 0.29, blue: 0.05, alpha: 1))).multilineTextAlignment(.center)
        }
    }
    var restaurantdescription: some View {
        VStack(spacing:10){
        //Delivery info
        Text(recipe.strInstructions ?? "").font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                .padding(.trailing,220)
        //Delivered between monday a...
            Text(recipe.strInstructions ?? "").font(.system(size: 15, weight: .regular)).tracking(0.3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
        }
    }
   
}

struct DetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = Recipe(idMeal: "1", strMeal: "Spaghetti", strDrinkAlternate: nil, strCategory: "Pasta", strArea: "Italian", strInstructions: "1. Cook spaghetti. 2. Heat up tomato sauce. 3. Mix together. 4. Enjoy!", strMealThumb: "https://www.themealdb.com/images/media/meals/xgldt71583233017.jpg", strTags: "pasta,italian,spaghetti", strYoutube: "https://www.youtube.com/watch?v=-d3ljWVQZRU", strIngredient1: "Spaghetti", strIngredient2: "Tomato Sauce", strIngredient3: "Parmesan Cheese")

        DetailsPage(recipe: recipe)
    }
}
