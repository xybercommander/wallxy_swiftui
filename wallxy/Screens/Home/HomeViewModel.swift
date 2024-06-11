//
//  HomeViewModel.swift
//  wallxy
//
//  Created by Samrat Mukherjee on 10/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var imageResponse: ImageResponse = ImageResponse()
    @Published var photoList: [String] = []
    @Published var initLoading: Bool = false
    
    func fetchHomeImages() {
        let url = URL(string: "https://api.pexels.com/v1/curated?page=1&per_page=80")!
        var request = URLRequest(url: url)
        request.setValue("VZ2etbHGwRBamyvHw1W01i4Fj1OPy7roWm0jWxjcBMCX64uP6o8tvIkh", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        DispatchQueue.main.async {
            self.initLoading = true
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
            }
            do {
                let res = try JSONDecoder().decode(ImageResponse.self, from: data)
                self.imageResponse = res
                print("Response JSON: \(self.imageResponse)")
                DispatchQueue.main.async {
                    self.initLoading = false
                    for photo in self.imageResponse.photos ?? [] {
                        self.photoList.append(photo.src?.original ?? "")
                    }
                }
            } catch let error {
                print("Failed to parse JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.initLoading = false
                }
            }
        }
        
        task.resume()
    }
}
