//
//  LazyView.swift
//  DogGram
//
//  Created by yunus olgun on 3.07.2021.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    
    var content: () -> Content
    
    var body: some View {
        self.content()
    }
    
}
