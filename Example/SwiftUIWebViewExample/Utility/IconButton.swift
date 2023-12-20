import SwiftUI

struct IconButton: View {
    var image: Image
    var action: () -> Void

    init(_ image: Image, action: @escaping () -> Void) {
        self.image = image
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            image
                .font(.system(size: 19))
                .frame(width: 24, height: 24)
        }
    }
}
