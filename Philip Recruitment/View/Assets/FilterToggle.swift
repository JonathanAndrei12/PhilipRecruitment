//
//  FilterToggle.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 07/09/22.
//

import SwiftUI

struct FilterToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text("Filter")
                .foregroundColor(Color.white)
                .font(.callout)
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .orange))
        }
        .frame(width: 100, alignment: .center)
    }
}

struct FilterToggle_Previews: PreviewProvider {
    static var previews: some View {
        FilterToggle(isOn: .constant(true))
    }
}
