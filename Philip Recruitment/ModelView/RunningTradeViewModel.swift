//
//  RunningTradeViewModel.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 06/09/22.
//

import Foundation

class RunningTradeViewModel: ObservableObject {
    @Published var filterListArr: [String] = []
    @Published var filteredStocksArr: [Stock] = []
    @Published var isFiltering: Bool = false
    
    func filterStocks() {
        filteredStocksArr.removeAll()
        
        if filterListArr.isEmpty || isFiltering == false {
            for s in stocksArr {
                filteredStocksArr.append(s)
            }
        } else {
            for s in stocksArr {
                for f in filterListArr {
                    if s.name == f {
                        filteredStocksArr.append(s)
                    }
                }
            }
        }
    }
}
