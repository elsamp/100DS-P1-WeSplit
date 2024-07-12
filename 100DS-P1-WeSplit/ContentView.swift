//
//  ContentView.swift
//  100DS-P1-WeSplit
//
//  Created by Erica Sampson on 2024-07-10.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipAmount = 15
    
    @FocusState private var amountIsFocused:Bool

    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipAmount)
        
        let tipTotal = checkAmount * tipSelection / 100
        let totalCost = checkAmount + tipTotal
        let amountPerPerson = totalCost/peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach (2..<10) {
                            Text("\($0) People")
                        }
                    }
                    //.pickerStyle(.navigationLink) //show a new view with the selections. Requires the NavStack
                }
                
                Section("Tip Amount") {
                    Picker("Tip %", selection: $tipAmount) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Per Person Cost") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                        .foregroundColor(tipAmount > 0 ? .blue : .red)
                }
            }
            .navigationTitle("Check Splitting")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
