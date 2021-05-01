//
//  ImagePicker.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 1.03.2021.
//

import SwiftUI
import PhotosUI
import UIKit

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var isPresented:Bool
    @Binding var image: UIImage
    @Binding var isImageSelected:Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented, isImageSelected: $isImageSelected)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage
    @Binding var isPresented: Bool
    @Binding var isImageSelected: Bool
    
    init(image: Binding<UIImage>, isPresented: Binding<Bool>, isImageSelected: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
        self._isImageSelected = isImageSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
        self.isPresented = false
        self.isImageSelected = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isPresented:Bool
    @Binding var image:UIImage
    @Binding var isImageSelected:Bool
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIViewController {
        let photoPicker = UIImagePickerController()
        photoPicker.sourceType = sourceType
        photoPicker.delegate = context.coordinator
        return photoPicker
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return Coordinator(picker: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let picker:ImagePicker
        init(picker: ImagePicker) {
            self.picker = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.picker.image = selectedImage
            }
            self.picker.isPresented = false
            self.picker.isImageSelected = true
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.picker.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
