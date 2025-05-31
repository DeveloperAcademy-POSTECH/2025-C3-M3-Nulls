import SwiftUI

public struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    public init() {}

    public var body: some View {
        GlossaryListView(context: managedObjectContext)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
