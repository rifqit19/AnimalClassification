//
//  ContentView.swift
//  AnimalClassification
//
//  Created by rifqi triginandri on 28/06/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    
    @State private var offset: CGFloat = -(UIScreen.main.bounds.height/5)
    
    @State private var classifiedClass: String = ""
    @State private var probability: String = ""
    @State private var animalName: String = ""
    
    @State private var probabilities: [String: Double] = [:]
    let cat = ["Mml", "Brg", "Rtl","Ikn","Amp","Srg","Inv"]
    
    func formatProbability(_ value: Double) -> String {
        let formattedValue = String(format: "%.2f", value * 100)
        return "\(formattedValue)%"
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            Color.orange.ignoresSafeArea()
            VStack {
                Text("Klasifikasi Hewan")
                    .font(.headline)
                    .padding()
                
                ZStack(alignment: .center){
                    VStack{
                        Text("\(animalName)").padding(.bottom, -20)

                        Image("bg-animal")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .shadow(radius: 10)
                            .padding([.leading, .trailing], 10)
                        
                        if !probabilities.isEmpty{
                            HStack {
                                ForEach(probabilities.keys.sorted(), id: \.self) { key in
                                    VStack {
                                        if key == "1"{
                                            Text("Mml")
                                                .font(.headline)
                                        }else if key == "2"{
                                            Text("Brg")
                                                .font(.headline)
                                        }else if key == "3"{
                                            Text("Rtl")
                                                .font(.headline)
                                        }else if key == "4"{
                                            Text("Ikn")
                                                .font(.headline)
                                        }else if key == "5"{
                                            Text("Amp")
                                                .font(.headline)
                                        }else if key == "6"{
                                            Text("Srg")
                                                .font(.headline)
                                        }else if key == "7"{
                                            Text("Inv")
                                                .font(.headline)
                                        }else {
                                        }

                                        if let probability = probabilities[key] {
                                            Text(String(format: "%.2f", probability))
                                                .font(.subheadline)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding([.leading,.trailing], 10)
                            .padding(.top, -10)
                            .shadow(radius: 10)
                        }


                    }
                    
                    VStack{
                        Text("\(classifiedClass)")
                            .font(.title3)
                        Text("\(probability)").font(.headline)
                    }.padding(.bottom, 20)
                }
                
                

                
                Spacer()
                
            }
            GeometryReader{ geo in
                VStack{
                    BottomSheet(offset: $offset, classifiedClass: $classifiedClass, probability: $probability, animalNames: $animalName, probabilities: $probabilities)
                        .offset(y: geo.frame(in: .global).height-100)
                        .offset(y: offset)
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation {
                                if value.startLocation.y > geo.frame(in: .global).midX{
                                    
                                    if value.translation.height < -(UIScreen.main.bounds.height/5) && offset > (-geo.frame(in: .global).height + 110){
                                        offset = value.translation.height
                                    }
                                }
                                
                                if value.startLocation.y > geo.frame(in: .global).midX{
                                    if value.translation.height > -(UIScreen.main.bounds.height/5) && offset < -(UIScreen.main.bounds.height/5) {
                                        offset = (-geo.frame(in: .global).height + 110) + value.translation.height
                                    }
                                    
                                }
                                
                            }
                        }).onEnded({ value in
                            withAnimation {
                                if value.startLocation.y > geo.frame(in: .global).midX{
                                    if -value.translation.height > geo.frame(in: .global).midX{
                                        offset = (-geo.frame(in: .global).height + 110)
                                        
                                        return
                                        
                                    }
                                    offset = -(UIScreen.main.bounds.height/5)
                                    
                                }
                                
                                if value.startLocation.y < geo.frame(in: .global).midX{
                                    if value.translation.height < geo.frame(in: .global).midX{
                                        offset = (-geo.frame(in: .global).height + 110)
                                        
                                        return
                                        
                                    }
                                    offset = -(UIScreen.main.bounds.height/5)
                                    
                                }
                                
                            }
                        })
                        )
                }
            }.ignoresSafeArea(.all, edges: .bottom)
            
        })
    }
    
}

struct BottomSheet : View{
    
    @State private var animalName = ""
    @State private var hair = false
    @State private var feathers = false
    @State private var eggs = false
    @State private var milk = false
    @State private var airborne = false
    @State private var aquatic = false
    @State private var predator = false
    @State private var toothed = false
    @State private var backbone = false
    @State private var breathes = false
    @State private var venomous = false
    @State private var fins = false
    @State private var legs = 0
    @State private var tail = false
    @State private var domestic = false
    @State private var catsize = false
    
    @State private var showClassification = false
    
    @Binding var offset: CGFloat

    @Binding var classifiedClass: String
    @Binding var probability: String
    @Binding var animalNames: String

    @Binding var probabilities: [String: Double]

    func formatProbability(_ value: Double) -> String {
        let formattedValue = String(format: "%.2f", value * 100)
        return "\(formattedValue)%"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Capsule()
                .fill(Color.gray)
                .frame(width: 50, height: 5)
            
            HStack {
                Spacer()
                Text("Karakteristik Hewan")
                    .font(.headline)
                Spacer()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Nama Hewan")
                        .font(.headline)
                    TextField("Masukkan nama hewan", text: $animalName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Group{
                        ToggleRow(label: "Berambut", isOn: $hair)
                        ToggleRow(label: "Berbulu", isOn: $feathers)
                        ToggleRow(label: "Bertelur", isOn: $eggs)
                        ToggleRow(label: "Menyusui", isOn: $milk)
                        ToggleRow(label: "Dapat Terbang", isOn: $airborne)
                        ToggleRow(label: "Hidup di Air", isOn: $aquatic)
                        ToggleRow(label: "Predator", isOn: $predator)
                        ToggleRow(label: "Bertaring", isOn: $toothed)
                        ToggleRow(label: "Bertulang Belakang", isOn: $backbone)
                        ToggleRow(label: "Bernapas", isOn: $breathes)
                    }
                    ToggleRow(label: "Berbisa", isOn: $venomous)
                    ToggleRow(label: "Sirip", isOn: $fins)
                    
                    Stepper(value: $legs, in: 0...8, step: 2) {
                        Text("Jumlah Kaki: \(legs)")
                            .font(.headline)
                    }
                    
                    ToggleRow(label: "Berekor", isOn: $tail)
                    ToggleRow(label: "Dapat diternak", isOn: $domestic)
                    ToggleRow(label: "Catsize", isOn: $catsize)
                }
                .padding()
            }
            
            Button(action: {
                print("Animal Name: \(animalName)")
                print("Hair: \(hair ? 1 : 0)")
                print("Freather: \(feathers ? 1 : 0)")
                print("eggs: \(eggs ? 1 : 0)")
                print("milk: \(milk ? 1 : 0)")
                print("airborne: \(airborne ? 1 : 0)")
                print("aquatic: \(aquatic ? 1 : 0)")
                print("predator: \(predator ? 1 : 0)")
                print("toothed: \(toothed ? 1 : 0)")
                print("backbone: \(backbone ? 1 : 0)")
                print("breathes: \(breathes ? 1 : 0)")
                print("venomous: \(venomous ? 1 : 0)")
                print("fins: \(fins ? 1 : 0)")
                print("legs: \(legs)")
                print("tail: \(tail ? 1 : 0)")
                print("domestic: \(domestic ? 1 : 0)")
                print("catsize: \(catsize ? 1 : 0)")

                
                let prediction = testModel(hair: hair ? 1 : 0,
                                           feathers: feathers ? 1 : 0,
                                           eggs: eggs ? 1 : 0,
                                           milk: milk ? 1 : 0,
                                           airborne: airborne ? 1 : 0,
                                           aquatic: aquatic ? 1 : 0,
                                           predator: predator ? 1 : 0,
                                           toothed: toothed ? 1 : 0,
                                           backbone: backbone ? 1 : 0,
                                           breathes: breathes ? 1 : 0,
                                           venomous: venomous ? 1 : 0,
                                           fins: fins ? 1 : 0,
                                           legs: legs,
                                           tail: tail ? 1 : 0,
                                           domestic: domestic ? 1 : 0,
                                           catsize: catsize ? 1 : 0)
                
                if let classifiedClass = prediction?.class_type {
                    print("classified Class: \(classifiedClass)")
                    
                    if classifiedClass == 1{
                        self.classifiedClass = "Mamalia"
                    }else if classifiedClass == 2{
                        self.classifiedClass = "Burung"
                    }else if classifiedClass == 3{
                        self.classifiedClass = "Reptil"
                    }else if classifiedClass == 4{
                        self.classifiedClass = "Ikan"
                    }else if classifiedClass == 5{
                        self.classifiedClass = "Amphibi"
                    }else if classifiedClass == 6{
                        self.classifiedClass = "Serangga"
                    }else if classifiedClass == 7{
                        self.classifiedClass = "Invertebrate"
                    }else {
                        self.classifiedClass = "Tidak Terdeteksi"
                    }
                    
                }
                
                if let classifiedProbability = prediction?.class_typeProbability {
                    // Access the probabilities dictionary
                    
                    probabilities = classifiedProbability.reduce(into: [:]) { (result, keyValue) in
                        let (key, value) = keyValue
                        let stringKey = String(key)
                        result[stringKey] = value
                    }

                    for (key, value) in classifiedProbability {
                        let maxEntry = classifiedProbability.max { $0.value < $1.value }
                        
                        print(" Probability: \(maxEntry?.key)")
                        

                        if let maxKey = maxEntry?.key, let probability = classifiedProbability[maxKey] {
                            print(" Probability: \(formatProbability(probability))")
                            self.probability = formatProbability(probability)
                        }

                    }
                }
                
                self.animalNames = animalName

                withAnimation{
                    offset = -(UIScreen.main.bounds.height/5)
                }
            }) {
                Text("Klasifikasi")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.blue)
                    )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: -5)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func testModel(hair: Int, feathers: Int, eggs: Int, milk: Int, airborne: Int, aquatic: Int, predator: Int, toothed: Int, backbone: Int, breathes: Int, venomous: Int, fins: Int, legs: Int, tail: Int, domestic: Int, catsize: Int) -> AnimalClassifierOutput? {
    do {
        let config = MLModelConfiguration()
        let model = try AnimalClassifier(configuration: config)
        
        let prediction = try model.prediction(hair: Double(hair), feathers: Double(feathers), eggs: Double(eggs), milk: Double(milk), airborne: Double(airborne), aquatic: Double(aquatic), predator: Double(predator), toothed: Double(toothed), backbone: Double(backbone), breathes: Double(breathes), venomous: Double(venomous), fins: Double(fins), legs: Double(legs), tail: Double(tail), domestic: Double(domestic), catsize: Double(catsize))
        
        return prediction
    } catch {
        // Handle any errors that occur during model initialization or prediction
        print("Error: \(error)")
        return nil
    }
}

struct ToggleRow: View {
    let label: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(label)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}
