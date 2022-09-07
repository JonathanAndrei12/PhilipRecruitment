//
//  Stocks.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 06/09/22.
//

import Foundation

struct Stock: Identifiable {
    let id: Int
    let name: String
    let price: String
    let chgPlusMin: String
    let chg: String
    let vol: String
    let act: String
    let time: String
}

var stocksArr: [Stock] = []
let stocksNameArr: [String] = ["ADRO", "BBCA", "CLEO", "GOTO", "WIKA"]

func autoFillStock() {
    var counter = 1
    
    while(counter <= 25) {
        let plusMin = getPlusMin()
        
        let s = Stock(id: counter, name: getName(), price: getPrice(), chgPlusMin: plusMin, chg: getCHG(plusMin: plusMin), vol: getVol(), act: getAct(), time: getTime())
        stocksArr.append(s)
        
        counter += 1
    }
}

func getName() -> String {
    let stocksNameArr: [String] = ["ADRO", "BBCA", "CLEO", "GOTO", "WIKA"]
    return stocksNameArr[Int.random(in: 0...(stocksNameArr.count - 1))]
}

func getPrice() -> String {
    return Int.random(in: 1000...9999).formattedWithCommaSeparator
}

func getPlusMin() -> String {
    let chgArr: [String] = ["+", "-", "N"]
    return chgArr[Int.random(in: 0...(chgArr.count - 1))]
}

func getCHG(plusMin: String) -> String {
    if plusMin == "N" {
        return "0.00%"
    } else {
        let percentage: Double = Double.random(in: 0.00...100.00)
        let stringForm = String(format: "%.2f", percentage)
        return "\(plusMin)\(stringForm)%"
    }
}

func getVol() -> String {
    return Int.random(in: 10...10000000).formattedWithCommaSeparator
}

func getAct() -> String {
    let actArr: [String] = ["BU", "SD"]
    return "\(actArr[Int.random(in: 0...(actArr.count - 1))])"
}

func getTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let min = calendar.component(.minute, from: date)
    let sec = calendar.component(.second, from: date)
    return "\(hour):\(min):\(sec)"
}

extension Formatter {
    static let withCommaSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}

extension Numeric {
    var formattedWithCommaSeparator: String { Formatter.withCommaSeparator.string(for: self) ?? "" }
}

//extension Int {
//    func withCommas() -> String {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        return numberFormatter.string(from: NSNumber(value:self))!
//    }
//}
