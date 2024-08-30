//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

import Foundation

extension Locale {
    
    func minimalIdentifier() -> String {
        var code = ""
        if #available(iOS 16.0, *) {
            code = Locale.current.language.minimalIdentifier
        } else {
            code = Locale.current.languageCode ?? "en"
        }
        return code
    }
}
