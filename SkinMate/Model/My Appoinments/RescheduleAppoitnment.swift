//
//  RescheduleAppoitnment.swift
//  SkinMate
//
//  Created by Datamatics on 13/05/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit
// API Call to Reschedule an appointment.
class RescheduleAppointment {
    static let shared = RescheduleAppointment()
    init() {
    }
    func reschedulAppointment(appointmentId : String){
        let deviceId: String? = KeychainWrapper.standard.string(forKey: "deviceId")
        let tokenId: String? = KeychainWrapper.standard.string(forKey: "tokenId")
        if let url = URL(string: "\(MyAppointmentAPI.shared.rescheduleApointment)\(appointmentId)"){
            var request = URLRequest(url: url)
            
            request.setValue(deviceId, forHTTPHeaderField: "device-id")
            request.setValue(tokenId, forHTTPHeaderField: "access-token")
            
            
            request.httpMethod = "PATCH"
            let parameters: [String : Any] = [:
            ]
            
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    if response.statusCode == 200 {
                        print("\(response.statusCode)")
                    } else {
                        print("\(response.statusCode)")
                    }
                }
                
                do{
                    let _ = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                }catch let error{
                    print(error.localizedDescription)
                }
                }.resume()
        }
    }
}
