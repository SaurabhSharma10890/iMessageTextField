//
//  MessageTextField.swift
//  iMessageTextField
//
//  Created by Saurabh Sharma on 07/12/24.
//

import SwiftUI

struct MessageTextField: View {
    @Binding var inputText: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                ZStack(alignment: .bottomLeading) {
                    TextEditor(text: $inputText)
                        .frame(minHeight: 36)
                        .fixedSize(horizontal: false, vertical: true)
                        .submitLabel(.done)
                        .focused($isFocused)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .font(.system(size: 15))
                        .padding([.top, .bottom, .leading], 2)
                        .accentColor(Color.green)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .overlay(
                            // Placeholder
                            Group {
                                if inputText.isEmpty {
                                    Text("Enter your message")
                                        .foregroundColor(.gray.opacity(0.5))
                                        .font(.system(size: 15))
                                        .padding(.leading, 6)
                                }
                            },
                            alignment: .leading
                        )
                        .onSubmit {
                            dismissKeyboard()
                        }
                        .onChange(of: inputText) { textInput in
                            var newValue =  textInput
                            if textInput.count > 400 {
                                newValue = String(textInput.prefix(400))
                                if (textInput.last?.isNewline) ?? false {
                                    isFocused = false
                                }
                            }
                            inputText = newValue
                        }
                }
                
                // Mic Button
                Button(action: {
                    // Add microphone action here
                }) {
                    Image(systemName: "mic")
                        .font(.system(size: 20))
                        .foregroundColor(.green)
                }
                .padding(.bottom, 8)
                
                // Send Button
                Button(action: {
                    if !inputText.isEmpty {
                        // Add send message action here
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(inputText.isEmpty ? .gray : .green)
                }
                
                .padding(.trailing, 4)
                .padding(.bottom, 8)
                .disabled(inputText.isEmpty)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
            )
        }
        .padding([.leading, .trailing], 20)
    }
    
    // Helper function to dismiss the keyboard
    private func dismissKeyboard() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isFocused = false
        }
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension View {
    func onEnter(@Binding of text: String, action: @escaping () -> ()) -> some View {
        onChange(of: text) { newValue in
            if let last = newValue.last, last == "\n" {
                text.removeLast()
                action()
            }
        }
    }
}


#Preview {
    MessageTextField(inputText: .constant(""))
}
