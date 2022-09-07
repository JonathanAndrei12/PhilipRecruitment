//
//  AddStockView.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 07/09/22.
//

import SwiftUI

struct AddStockView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var choosenStock: String
    
    var body: some View {
        ZStack {
            Color("RunningTradeBackground")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible())
                ], spacing: 0) {
                    ForEach(stocksNameArr, id: \.self) { name in
                        VStack {
                            HStack {
                                Text(name)
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.white)
                            }
                            .padding(.horizontal, 5)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                choosenStock = name
                                self.presentationMode.wrappedValue.dismiss()
                            }
                                
                                
                            Divider()
                                .overlay(.white)
                                .padding(.vertical, 0)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    }
                }
            }
            .padding(.top, 60)
            
            VStack {
                Text("STOCKS")
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            .padding(.top, 20)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            VStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.orange)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 23)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct AddStockView_Previews: PreviewProvider {
    static var previews: some View {
        AddStockView(choosenStock: .constant(""))
    }
}
