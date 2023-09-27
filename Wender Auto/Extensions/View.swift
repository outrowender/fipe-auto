//
//  View.swift
//  Wender Auto
//
//  Created by Wender on 27/09/23.
//

import Foundation
import SwiftUI

struct OnLoadViewModifier: ViewModifier {
    let perform:() -> Void
    @State private var firstTime: Bool = true
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if firstTime {
                    firstTime = false
                    self.perform()
                }
            }
    }
}

extension View {
    func onLoad(perform: @escaping () -> Void) -> some View {
        self.modifier(OnLoadViewModifier(perform: perform))
    }
}
