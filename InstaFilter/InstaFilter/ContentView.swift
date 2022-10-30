//
//  ContentView.swift
//  InstaFilter
//
//  Created by Cheng Liang(Louis) on 2022/10/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    
    @State private var inputImage: UIImage?
    
    @State private var processedImage: UIImage?
    
    @State private var showingImagePicker = false
    
    @State private var filterIntensity = 0.5
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    let context = CIContext()
    
    @State private var showingFilterSheet = false

    
    var body: some View {
//MARK: Image Picker
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//
//            Button("Select Image"){
//                showingImagePicker = true
//            }
//
//            Button("Save Image") {
//                guard let inputImage = inputImage else { return }
//                let imageSaver = ImageSaver()
//                imageSaver.writeToPhotoAlbum(image: inputImage)
//            }
//        }.sheet(isPresented: $showingImagePicker) {
//            ImagePicker(image: $inputImage)
//        }
//        .onChange(of: inputImage, perform:{_ in loadImage()})
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in
                            applyProcessing()
                        }
                }.padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
                .padding([.horizontal, .bottom])
                .navigationTitle("Instafilter")
                .onChange(of: inputImage) {_ in loadImage()}
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                    Button("Cystalize") {
                        setFilter(CIFilter.crystallize())
                    }
                    Button("Edges") {
                        setFilter(CIFilter.edges())
                    }

                    
                    Button("Gaussian Blur") {
                        setFilter(CIFilter.gaussianBlur())
                    }

                    
                    Button("Pixellate") {
                        setFilter(CIFilter.pixellate())
                    }

                    
                    
                    Button("Sepia Tone") {
                        setFilter(CIFilter.sepiaTone())
                    }

                    
                    Button("Unsharp Mask") {
                        setFilter(CIFilter.unsharpMask())
                    }
                    
                    Button("Vignette") {
                        setFilter(CIFilter.vignette())
                    }

                    Button("Cancel", role: .cancel) {}


                }
                
                
            }
        }

    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    
    
    func save(){
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: processedImage)
        
    }
    
    func applyProcessing(){
        

        
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
//    func loadImage(){
//        guard let inputImage = UIImage(named: "Example") else { return }
//        let beginImage = CIImage(image:  inputImage)
//
//        let context = CIContext()
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//
//        let amount = 1.0
//        let inputKeys = currentFilter.inputKeys
//
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
//        }
//        if inputKeys.contains(kCIInputRadiusKey) {
//            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
//        }
//
//
//        if inputKeys.contains(kCIInputScaleKey) {
//            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
//        }
//
//
//
//        guard let outputImage = currentFilter.outputImage else { return }
//
//        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
//            let uiImage = UIImage(cgImage: cgimg)
//            image = Image(uiImage: uiImage)
//        }
//
//
//    }
}


