//
//  ThemePicker.swift
//  NewScrumdinger
//
//  Created by 백대홍 on 10/18/23.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in //모든 케이스를 나열
                ThemeView(theme: theme)
                    .tag(theme)
            }
            
        }.pickerStyle(.wheel)
    }
}

#Preview {
    ThemePicker(selection: .constant((.periwinkle)))
}



/*
 PickerStyle 변경
 
 
 */
