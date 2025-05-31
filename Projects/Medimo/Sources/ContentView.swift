import SwiftUI

public struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    
    public init() {}

    public var body: some View {
        GlossaryListView(context: context)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
