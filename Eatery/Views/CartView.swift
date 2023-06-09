//
//  CartView.swift
//  Eatery
//
//  Created by BIJAY on 16/03/2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ViewModel
    @State var isTransactionProcessing = false
    @State var isTransactionSuccessful = false
    
    
    var body: some View {
      
        ScrollView{
            
            
            if viewModel.cartItems.isEmpty {
                Image("empty-cart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                
                Text("Your cart is empty!")
                
                Text("All your cart items will appear here.")
                    .font(.system(size: 12))
                    .padding(12)
                    .foregroundColor(Color.gray)
                
                
            } else {
                HStack{
                    Text("Cart Items (" + String(viewModel.cartItems.count) + ")")
                        .font(.system(size: 18))
                        .bold()
                        .padding(EdgeInsets(top: 20, leading: 18, bottom: 50, trailing: 18))
                    Spacer()
                }
                
                
                ForEach(viewModel.cartItems){ foodItem in
                    CartItemView(id: foodItem.id, title: foodItem.item, price: foodItem.price, callback: {
                        viewModel.removeFromCart(foodItem: foodItem)
                        
                    }).padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                
                
                Divider()
                
                HStack(){
                    Spacer()
                    Text("Total")
                        .bold()
                      
                    
                    
                    
                    Text("$" + String(viewModel.getTotalCost()))
                        .font(.system(size:18))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                }
                    
                
                if isTransactionProcessing {
                    NavigationLink(destination: PaymentSuccessView(viewModel: viewModel, amount: viewModel.getTotalCost()), isActive:  $isTransactionSuccessful){
                        
             
                    ProgressView()
                        .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                    
                    }
                    
                }else {
                    
                    Text("Pay Now")
                        .font(.headline)
                        .frame(width: 200, height: 40, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.9580881, green: 0.10593573,
                                                        blue: 0.3403331637, alpha: 1)))
                    
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 28, leading: 0, bottom: 0, trailing: 0))
                        .onTapGesture {
                            isTransactionProcessing = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                                isTransactionSuccessful = true
                              
                                
                            }
                        }
                }
            }
                               
                               
                
         
        }

        
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: ViewModel())
    }
}
