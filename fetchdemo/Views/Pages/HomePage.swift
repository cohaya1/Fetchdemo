//
//  HomePage.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import SwiftUI

struct HomePage: View {
    @State private var desserts: [DessertModel] = []
       @State private var mealDetail: MealDetail?
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
            VStack {
                Button(action: {}, label: {
                    //see more
                    Text("see more").font(.system(size: 15, weight: .regular, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.98, green: 0.29, blue: 0.05, alpha: 1)))
                        .padding(.leading,230)
                       
            })
            }.padding(.top,30)
            LazyVStack {
              
                
                    ScrollView(Axis.Set.horizontal,showsIndicators: false) {
                        LazyHStack(spacing:45){ // pass in restaurant object for view to show up in other view
                            ForEach(desserts, id:\.id) { dessert in
                                NavigationLink(destination: DetailsPage(mealID: dessert.id)) {
                                    MealTableListItem(meallists: dessert)
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
                .frame( height: 400)
        }
        .navigationBarHidden(true)
        }.navigationBarHidden(true)
    
    }
    
    var settingsicon: some View {
        Image("settingsicon")
            .resizable()
            .frame(width: 22, height: 14.67)
            .scaledToFit()
    }
    var delicioustext: some View {
        //Delicious food for you
        Text("Delicious \nfood for you").font(.system(size: 34, weight: .bold, design: .rounded))
    }
    

   

var restauranttable: some View {
    
   // let restaurant : Restaurant
    
    
    ZStack {
       
        //Ellipse 2
       
        //Rectangle 9
        
        
        
        RoundedRectangle(cornerRadius: 30)
            .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .frame(width: 220, height: 270)
        .shadow(color: Color(#colorLiteral(red: 0.22499999403953552, green: 0.22499999403953552, blue: 0.22499999403953552, alpha: 0.10000000149011612)), radius:60, x:0, y:30)
       
            
        //Ellipse 2
        // Composition groups need to live inside some a stack. (VStack, ZStack, or HStack)

        ZStack {
            Circle()
            .fill(Color(#colorLiteral(red: 0.949999988079071, green: 0.949999988079071, blue: 0.949999988079071, alpha: 1)))

            Circle()
            .strokeBorder(Color(#colorLiteral(red: 0.949999988079071, green: 0.949999988079071, blue: 0.949999988079071, alpha: 1)), lineWidth: 1)
        }
        .compositingGroup()
        .frame(width: 164.2, height: 174.2)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 4)), radius:4, x:0, y:4)
        .padding(.bottom,200)
        VStack(spacing: 25){
            Text("viewModel.resta").font(.system(size: 22, weight: .semibold, design: .rounded)).multilineTextAlignment(.center)
        Text("N1,900").font(.system(size: 17, weight: .bold, design: .rounded)).foregroundColor(Color(#colorLiteral(red: 0.98, green: 0.29, blue: 0.05, alpha: 1))).multilineTextAlignment(.center)
       
        }.padding(.top,100)
    }

}
}
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
