//
//  ContentView.swift
//  WeSplit
//
//  Created by Mathieu Dubart on 02/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused : Bool
    
    var peopleCount: Double { Double(numberOfPeople + 2) }
    var tipValue: Double { checkAmount / 100 * Double(tipPercentage) }
    var grandTotal: Double { checkAmount + tipValue }
    var totalPerPerson: Double { grandTotal / peopleCount }
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section {
                        TextField("Enter the amount", value: $checkAmount, format:
                                .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100){
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0..<101) {
                                Text($0, format:.percent)
                            }
                        }
                        .pickerStyle(.wheel)
                    } header: {
                        Text("How much tip do you want to leave ?")
                    }
                    
                    Section {
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                            .foregroundColor(tipPercentage == 0 ? .red : .black)
                    } header: {
                        Text("Total amount")
                    }
                    
                    Section {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    } header: {
                        Text("Amount per person")
                    }
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocused = false
                        }
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
