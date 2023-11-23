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
                Circle()
                    .fill(Color.secondary)
                    .frame(width: 150, height: 150)

                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                } else {
                    Text("Select a Profile Picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture {
                isImagePickerPresented.toggle()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(selectedImage: $profileImage)
            }
        }
        .padding()
    }
}

struct ImagePickerView: View {
    @Binding var selectedImage: Image?

    @State private var isImagePickerPresented: Bool = false
    @State private var selectedUIImage: UIImage?

    var body: some View {
        ImagePicker(image: $selectedUIImage, isImagePickerPresented: $isImagePickerPresented)
            .onDisappear {
                if let selectedUIImage = selectedUIImage {
                    selectedImage = Image(uiImage: selectedUIImage)
                }
            }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isImagePickerPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        return imagePickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update any configurations if needed
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.editedImage] as? UIImage {
                parent.image = selectedImage
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
