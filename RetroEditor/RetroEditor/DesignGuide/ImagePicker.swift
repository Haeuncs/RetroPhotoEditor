//
//  ImagePicker.swift
//  RetroEditor
//
//  Created by LEE HAEUN on 2020/11/02.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode

    var completion: ((UIImage) -> Void)

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        var completion: ((UIImage) -> Void)

        init(
            presentationMode: Binding<PresentationMode>,
            completion: @escaping ((UIImage) -> Void)
        ) {
            _presentationMode = presentationMode
            self.completion = completion
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            let uiImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            completion(uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, completion: completion)
    }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ImagePicker>
    ) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<ImagePicker>
    ) {

    }

}
