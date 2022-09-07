//
//  StockFilterSheet.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 07/09/22.
//

import SwiftUI
import HalfASheet

struct StockFilterSheet: View {
    
    @Binding var isShowingFilterSheet: Bool
    @Binding var tempStocksArr: [String]
    @Binding var isApplied: Bool
    @State var isDisabled: Bool = false
    @State var currentChosenStock: String = ""
    @State var isAddingStock: Bool = false
    var body: some View {
        HalfASheet(isPresented: $isShowingFilterSheet) {
            ZStack {
                VStack(alignment: .leading) {
                    Button(action: {
                        tempStocksArr.removeAll()
                    }) {
                        Text("CLEAR FILTER")
                            .font(.callout)
                            .foregroundColor(Color.orange)
                    }
                    .padding(.bottom, 10)
                    
                    Text("You can add to maximum of 10 stocks")
                        .font(.callout)
                        .foregroundColor(Color.gray)
                    
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 5),
                        GridItem(.flexible(), spacing: 5),
                        GridItem(.flexible()),
                    ], alignment: .leading, spacing: 5) {
                        if !tempStocksArr.isEmpty {
                            ForEach(0...(tempStocksArr.count-1), id: \.self) { i in
                                Button(action: {
                                    tempStocksArr.remove(at: i)
                                }) {
                                    HStack {
                                        Text("\(tempStocksArr[i])")
                                        Image(systemName: "xmark")
                                    }
                                    .foregroundColor(Color.white)
                                    .padding(10)
                                    .background(Color("StockFilterButtonBackground"))
                                    .cornerRadius(5)
                                }
                            }
                        }
                        
                        Button(action: {
                            isAddingStock.toggle()
                        }) {
                            HStack {
                                Text("Add Stock")
                                    .lineLimit(1)
                                    .frame(width: 80)
                                Image(systemName: "plus")
                            }
                            .foregroundColor(Color.orange)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.orange, lineWidth: 1)
                            )
                        }
                        .disabled(isDisabled)
                        
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Text("STOCK FILTER")
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                .padding(.top, 10)
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        isApplied = true
                        isShowingFilterSheet = false
                    }) {
                        Text("Apply")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                            .background(Color.orange)
                            .cornerRadius(5)
                    }
                }
            }
        }
        .backgroundColor(UIColor(named: "FilterBarBackground")!)
        .closeButtonColor(.orange)
        .height(.proportional(0.5))
        .onChange(of: tempStocksArr.count) { val in
            if val < 10 {
                isDisabled = false
            } else {
                isDisabled = true
            }
        }
        .onAppear {
            if tempStocksArr.count < 10 {
                isDisabled = false
            } else {
                isDisabled = true
            }
        }
        .onChange(of: currentChosenStock) { val in
            if val != "" {
                var isDup = false
                
                for i in tempStocksArr {
                    if val == i {
                        isDup = true
                        break
                    }
                }
                
                if !isDup {
                    tempStocksArr.append(val)
                }
            }
        }
        .sheet(isPresented: $isAddingStock) {
            AddStockView(choosenStock: $currentChosenStock)
        }
    }
}

struct StockFilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        StockFilterSheet(isShowingFilterSheet: .constant(true), tempStocksArr: .constant([]), isApplied: .constant(false))
    }
}
