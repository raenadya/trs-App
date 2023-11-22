import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label = ""
    
    var maximumRating = 5
    
    var editable = true
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
                Spacer()
            }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    if editable {
                        rating = number
                    }
                } label: {
                    image(for: number)
                        .foregroundColor(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number <= rating {
            return onImage
        } else {
            return offImage ?? onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
