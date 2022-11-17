//
//  ContentView.swift
//  ConversionChallenge1
//
//  Created by Ангелина Шаманова on 15.11.22..
//

import SwiftUI

enum TemperatureFormat: String {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var description: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
}

struct ContentView: View {
    @State private var inputTemperature: String = ""
    @State private var selectedInputFormat: TemperatureFormat = .fahrenheit
    
    @State private var outputTemperature: String = "0"
    @State private var selectedOutputFormat: TemperatureFormat = .celsius
    
    @FocusState private var textFieldIsFocused: Bool
    
    private var temperatureFormat: [TemperatureFormat] = [.celsius, .fahrenheit, .kelvin]
    
    private var outputDegrees: String {
        let inputDouble = Float(inputTemperature) ?? 0
        if selectedInputFormat == .celsius {
            switch selectedOutputFormat {
            case .celsius:
                return inputTemperature
            case .fahrenheit:
                let degrees = ((inputDouble * 9/5) + 32)
                return "\(degrees)"
            case .kelvin:
                return "\(inputDouble + 273.15)"
            }
        } else if selectedInputFormat == .fahrenheit {
            switch selectedOutputFormat {
            case .celsius:
                let degrees = ((inputDouble - 32) * 5/9)
                return "\(degrees)"
            case .fahrenheit:
                return inputTemperature
            case .kelvin:
                let degrees = (((inputDouble - 32) * 5/9) + 273.15)
                return "\(degrees)"
            }
        } else {
            switch selectedOutputFormat {
            case .celsius:
                let degrees = inputDouble - 273.15
                return "\(degrees)"
            case .fahrenheit:
                let degrees = (((inputDouble - 273.15) * 9/5) + 32)
                return "\(degrees)"
            case .kelvin:
                return inputTemperature
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Format", selection: $selectedInputFormat) {
                        ForEach(temperatureFormat, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("Degrees", text: $inputTemperature)
                        .keyboardType(.decimalPad)
                        .focused($textFieldIsFocused)
                } header: {
                    Text("Input temperature")
                }
                Section {
                    Picker("Format", selection: $selectedOutputFormat) {
                        ForEach(temperatureFormat, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("\(outputDegrees)\(selectedOutputFormat.description)")
                } header: {
                    Text("Output temperature")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Temperature Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        textFieldIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
