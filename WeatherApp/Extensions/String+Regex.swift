//
// Copyright © 2024  Nykiel Jakub. All rights reserved.
//

public extension String {
    
    static let searchRegex = "^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\\s]*$"
    
    func matches(regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
