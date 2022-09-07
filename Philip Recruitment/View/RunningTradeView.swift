//
//  RunningTradeView.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 06/09/22.
//

import SwiftUI
import HalfASheet

struct RunningTradeView: View {
    init() {
        let appearance =  UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "NavBarBackground")
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        UIScrollView.appearance().bounces = false
    }
    
    @StateObject var runningTradeVM = RunningTradeViewModel()
    @State var isShowingFilterSheet: Bool = false
    @State var tempStocksArr: [String] = []
    @State var isApplied: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("RunningTradeBackground")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible())
                    ], spacing: 0) {
                        HStack {
                            Text("STOCK")
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("PRICE")
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text("CHG")
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text("VOL")
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text("ACT")
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("TIME")
                                .font(.caption2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .frame(width: UIScreen.main.bounds.width, alignment: .center)
                        .background(Color("NavBarBackground"))
                        
                        ForEach(runningTradeVM.filteredStocksArr, id: \.id) { stock in
                            VStack(spacing: 0) {
                                HStack {
                                    Text("\(stock.name)")
                                        .font(.caption2)
                                        .foregroundColor(stock.chgPlusMin == "N" ? Color.orange : stock.chgPlusMin == "+" ? Color.green : Color.red)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(stock.price)")
                                        .font(.caption2)
                                        .foregroundColor(stock.chgPlusMin == "N" ? Color.orange : stock.chgPlusMin == "+" ? Color.green : Color.red)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    Text("\(stock.chg)")
                                        .font(.caption2)
                                        .foregroundColor(stock.chgPlusMin == "N" ? Color.orange : stock.chgPlusMin == "+" ? Color.green : Color.red)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    Text("\(stock.vol)")
                                        .font(.caption2)
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    Text("\(stock.act)")
                                        .font(.caption2)
                                        .foregroundColor(stock.act == "BU" ? Color.green : Color.red)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(stock.time)")
                                        .font(.caption2)
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width, alignment: .center)
        //                        .border(Color.red)
                                
                                Divider()
                                    .overlay(.white)
                                    .padding(.vertical, 0)
                            }
                        }
                    }
                    .padding(.top, 0)
                }
                .padding(.top, 0)
                
                VStack {
                    Spacer()
                    
                    FilterBar(isShowingFilterSheet: $isShowingFilterSheet, filterListArr: $runningTradeVM.filterListArr, isFiltering: $runningTradeVM.isFiltering)
                    
//                    HStack {
//                        Button(action: {
//                            isShowingFilterSheet.toggle()
//                        }) {
//                            HStack {
//                                Image(systemName: "line.3.horizontal.decrease")
//                                    .foregroundColor(Color.orange)
//                                Text("Stock Filter")
//                                    .font(.callout)
//                                    .foregroundColor(Color.orange)
//                                
//                                if !runningTradeVM.filterListArr.isEmpty {
//                                    Text("(\(runningTradeVM.filterListArr.count))")
//                                        .font(.callout)
//                                        .foregroundColor(Color.orange)
//                                }
//                            }
//                            .frame(width: UIScreen.main.bounds.width/2, alignment: .center)
//                        }
//                        
//                        Divider()
//                            .overlay(.white)
//                        
//                        FilterToggle(isOn: $runningTradeVM.isFiltering)
//                        .frame(width: UIScreen.main.bounds.width/2, alignment: .center)
//                    }
//                    .padding(.vertical, 10)
//                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .bottom)
//                    .background(Color("FilterBarBackground"))
                }
                
                StockFilterSheet(isShowingFilterSheet: $isShowingFilterSheet, tempStocksArr: $tempStocksArr, isApplied: $isApplied)
            }
            .navigationBarTitle("RUNNING TRADE", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack(alignment: .trailing) {
                        Text("7208.36")
                            .font(.body)
                            .foregroundColor(Color.white)
                        Text("+76.32(+1.07%)")
                            .font(.caption)
                            .foregroundColor(Color.green)
                    }
                }
            }
        }
        .onAppear {
            runningTradeVM.filterStocks()
        }
        .onChange(of: runningTradeVM.isFiltering) { val in
            runningTradeVM.filterStocks()
        }
        .onChange(of: isApplied) { val in
            if val {
                runningTradeVM.filterListArr = tempStocksArr
                isApplied = false
            }
        }
        .onChange(of: runningTradeVM.filterListArr) { val in
            runningTradeVM.filterStocks()
        }
    }
}

struct RunningTradeView_Previews: PreviewProvider {
    static var previews: some View {
        RunningTradeView()
    }
}
