//  SettingsView.swift
import SwiftUI

struct TextFieldWithValidation: View {
    var title: String
    @Binding var value: Double
    var formatter: NumberFormatter
    var minimumValue: Double

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("", value: $value, formatter: formatter)
                .onChange(of: value) { newValue in
                    if value < minimumValue {
                        value = minimumValue
                    }
                    if let maximum = formatter.maximum?.doubleValue,
                       value > maximum {
                        value = maximum
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100)
        }
    }
}

struct SettingsView: View {
    @Binding var showSettings: Bool
    @Binding var overlayColor: Color
    @Binding var backgroundColor: Color
    @Binding var inhaleDuration: Double
    @Binding var postInhaleHoldDuration: Double
    @Binding var exhaleDuration: Double
    @Binding var postExhaleHoldDuration: Double
    @Binding var drift: Double
    @Binding var overlayOpacity: Double
    
    func createNumberFormatter(minimumValue: Double, maximumValue: Double? = nil) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimum = NSNumber(value: minimumValue)
        if let max = maximumValue {
            formatter.maximum = NSNumber(value: max)
        }
        formatter.usesGroupingSeparator = false
        return formatter
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                VStack {
                    Form {
                        VStack(alignment: .leading, spacing: 10) {
                            ColorPicker("Overlay Color", selection: $overlayColor, supportsOpacity: true)
                            
                            ColorPicker("Background Color", selection: $backgroundColor, supportsOpacity: true)
                            
                            TextFieldWithValidation(title: "Inhale Duration (s)", value: $inhaleDuration, formatter: createNumberFormatter(minimumValue: 0.5), minimumValue: 0.5)
                            
                            TextFieldWithValidation(title: "Post-Inhale Hold (s)", value: $postInhaleHoldDuration, formatter: createNumberFormatter(minimumValue: 0), minimumValue: 0)
                            
                            TextFieldWithValidation(title: "Exhale Duration (s)", value: $exhaleDuration, formatter: createNumberFormatter(minimumValue: 0.5), minimumValue: 0.5)
                            
                            TextFieldWithValidation(title: "Post-Exhale Hold (s)", value: $postExhaleHoldDuration, formatter: createNumberFormatter(minimumValue: 0), minimumValue: 0)
                            
                            TextFieldWithValidation(title: "Drift", value: $drift, formatter: createNumberFormatter(minimumValue: 0.5), minimumValue: 0.5)
                            
                            TextFieldWithValidation(title: "Overlay Opacity", value: $overlayOpacity, formatter: createNumberFormatter(minimumValue: 0, maximumValue: 1), minimumValue: 0)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.9))
                .cornerRadius(10)
                .shadow(radius: 10)
                .frame(width: 300)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.top)
    }
}
