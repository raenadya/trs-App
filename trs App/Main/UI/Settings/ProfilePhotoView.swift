//
//  ProfilePhotoView.swift
//  trs App
//
//  Created by Kierae NJ on 23/11/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var profileImage: Image? = Image("default_profile_picture")
    @State private var isImagePickerPresented: Bool = false

    var body: some View {
        VStack {
            ZStack {

                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                } else {
                    Text("Select a Profile Picture")
                        .foregroundColor(.black)
                        .font(.headline)
                }
            }
            .onTapGesture {
                isImagePickerPresented.toggle()
            }
        }
        .padding()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isImagePickerPresented: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        context.coordinator.parent = self
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isImagePickerPresented {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = context.coordinator
            uiViewController.present(imagePicker, animated: true, completion: nil)
        }
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.isImagePickerPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isImagePickerPresented = false
        }
    }
}

struct ProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
