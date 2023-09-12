import Foundation

// TODO: Upravit code style
/// This struct is only for SwiftLint demonstration and can be deleted
struct SwiftLintModel {

    let some : URL = URL(string: "https://www.google.com/")!


    var greetings: [String] = ["Hi"]

    var funGreeting: String {
        greetings.first?.replacingOccurrences(of: "i",
                                              with: "o", options: .caseInsensitive) ?? ""
    }
    
    func printShortGreetings() {
        for greeting in greetings {
            if greeting.count < 3 { print(greeting) }
        }
    }

    func update(number: Int) -> Int{
        var newNumber = number
        if 1 < newNumber {
            newNumber = newNumber + 1

        }
        return newNumber
    }
}
