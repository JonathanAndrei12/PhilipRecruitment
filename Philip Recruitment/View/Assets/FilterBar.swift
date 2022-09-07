//
//  FilterBar.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 07/09/22.
//

import SwiftUI

struct FilterBar: View {
    @Binding var isShowingFilterSheet: Bool
    @Binding var filterListArr: [String]
    @Binding var isFiltering: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                isShowingFilterSheet.toggle()
            }) {
                HStack {
                    Image(systemName: "line.3.horizontal.decrease")
                        .foregroundColor(Color.orange)
                    Text("Stock Filter")
                        .font(.callout)
                        .foregroundColor(Color.orange)
                    
                    if !filterListArr.isEmpty {
                        Text("(\(filterListArr.count))")
                            .font(.callout)
                            .foregroundColor(Color.orange)
                    }
                }
                .frame(width: UIScreen.main.bounds.width/2, alignment: .center)
            }
            
            Divider()
                .overlay(.white)
            
            FilterToggle(isOn: $isFiltering)
            .frame(width: UIScreen.main.bounds.width/2, alignment: .center)
        }
        .padding(.vertical, 10)
        .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .bottom)
        .background(Color("FilterBarBackground"))
    }
}

struct FilterBar_Previews: PreviewProvider {
    static var previews: some View {
        FilterBar(isShowingFilterSheet: .constant(false), filterListArr: .constant([]), isFiltering: .constant(false))
    }
}
