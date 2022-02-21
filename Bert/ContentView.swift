
import SwiftUI
import web3swift
import PromiseKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorageSwift
import Combine
import CryptoKit


var contract:ProjectContract?
var web3:web3?
var network:Network = .rinkeby
var wallet:Wallet?
var password = "dakata_7b" // leave empty string for ganache

var contractAddressHash = "0x2f1Aa3d2aF7F0Eb6272aF6055a5804eEa39FB31c"  

//var contractAddressHash = "0x9B82a0661c0D7f20E02A9027B1885622C41D32cb"

// N1 France  - 0x3c969Ed267038fbe1d9c7029278C29dC86138525
// N2 Spanish - 0xf2fc113bBAa8956fd6f9bb515192292BD34D4e04
// N3 Italy   - 0x2918df1bE4b9f208186Ecfccf7dD938589608d22
// N4 English - 0x6E0a838CB92B53cF8073284ac9b85213BF5cAa26
// N5 Spanish - 0x2f1Aa3d2aF7F0Eb6272aF6055a5804eEa39FB31c


struct ContentView: View {

//    @ObservedObject private var model = BooksViewModel()
    @ObservedObject var models = CountryRepository()
    @State var company : String = ""
    @State var medicine: String = ""
    @State var location = Locale.current
    @State var onSelect : Bool = false
    @State var dossi : String = ""
    @State var dossihashedValue : String = ""
    @State var showAlert : Bool = false

    @State var isShow : Bool = false
    @State var scanningText : String = ""
    @State var isMedic : Medic?
    @State private var  documentURL = NSURL(string: "https://firebasestorage.googleapis.com/v0/b/fir-todo2-4d9ab.appspot.com/o/Color.pdf?alt=media&token=25e021f4-842f-4a29-8796-ef2fae19587c")


    var body: some View {


        ZStack {

            Text("\(self.documentURL!.relativeString)")
                .foregroundColor(.clear)
                .onChange(of: documentURL!.relativeString) { _ in }
            Text("Scanner goes here...\n\(self.scanningText)")
                .foregroundColor(.clear)
                .onChange(of: scanningText) { _ in
//                    print("<<  \(scanningText)  >>")
                    let elements = self.scanningText.components(separatedBy: "/")
                    self.company = elements[0]
                    self.medicine = elements[1]
                }
            Text("company...\(self.medicine)")
                .foregroundColor(.clear)
                .onChange(of: medicine) { _ in
                    self.models.loadCountry(company: self.company, medicine: self.medicine)
                }
                .foregroundColor(.red)
            Text("\(dossi)")
                .foregroundColor(.clear)
                .onChange(of: dossi){ _ in }

            VStack(alignment: .center) {

             Image("10136")
                .resizable()
                .frame(width: 350, height: 200, alignment: .center)
                .padding(.top)
                .padding(.top)


                Text("ePI Scanner HackZurich 2021")
                    .font(.system(size: 21))
                    .foregroundColor(Color.blue.opacity(0.5))
                    .offset(y: -35)


//  MARK: - Buttons

//                HStack{
//// N-1
//                    Button(action: {
//                        contractAddressHash = "0x3c969Ed267038fbe1d9c7029278C29dC86138525"
//                        // Create wallet using either a private key or mnemonic
//                        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
//                        contract = ProjectContract(wallet: wallet!,contract: contractAddressHash)
//                        saveToFB(manifacturer: "Janssen", medicine: "OPSUMIT", fileName: "OPSUMIT-France", country: "France", flag: "🇫🇷", nomer: 0, hash: contractAddressHash )
//                        getProjectTitle()
//
//                    }) {
//                       Text("🇫🇷")
//                            .font(.largeTitle)
//                            .foregroundColor(.orange)
//                    }.offset(x: -20)
////   N-2
//                    Button(action: {
//                        contractAddressHash = "0xf2fc113bBAa8956fd6f9bb515192292BD34D4e04"
//                        // Create wallet using either a private key or mnemonic
//                        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
//                        contract = ProjectContract(wallet: wallet!,contract: contractAddressHash)
//                        saveToFB(manifacturer: "Janssen", medicine: "OPSUMIT", fileName: "OPSUMIT-Spanish", country: "Spanish", flag: "🇪🇸", nomer: 0, hash: contractAddressHash )
//                        getProjectTitle()
//
//                    }) {
//                       Text("🇪🇸")
//                            .font(.largeTitle)
//                            .foregroundColor(.orange)
//                    }.offset(x: -20)
////   N-3
//                    Button(action: {
//                        contractAddressHash = "0x2918df1bE4b9f208186Ecfccf7dD938589608d22"
//                        // Create wallet using either a private key or mnemonic
//                        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
//                        contract = ProjectContract(wallet: wallet!,contract: contractAddressHash)
//                        saveToFB(manifacturer: "Janssen", medicine: "SIMPONI", fileName: "SIMPONI_Italy", country: "Italy", flag: "🇮🇹", nomer: 0, hash: contractAddressHash )
//                        getProjectTitle()
//
//                    }) {
//                       Text("🇮🇹")
//                            .font(.largeTitle)
//                            .foregroundColor(.orange)
//                    }.offset(x: -20)
////  N-4
//                    Button(action: {
//                        contractAddressHash = "0x6E0a838CB92B53cF8073284ac9b85213BF5cAa26"
//                        // Create wallet using either a private key or mnemonic
//                        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
//                        contract = ProjectContract(wallet: wallet!,contract: contractAddressHash)
//                        saveToFB(manifacturer: "Janssen", medicine: "PONVORY", fileName: "PONVORY-English", country: "English", flag: "🇬🇧", nomer: 0, hash: contractAddressHash )
//                        getProjectTitle()
//
//                    }) {
//                       Text("🇬🇧")
//                            .font(.largeTitle)
//                            .foregroundColor(.orange)
//                    }.offset(x: -20)
////  N-5
//                    Button(action: {
//                        contractAddressHash = "0x2f1Aa3d2aF7F0Eb6272aF6055a5804eEa39FB31c"
//                        // Create wallet using either a private key or mnemonic
//                        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
//                        contract = ProjectContract(wallet: wallet!,contract: contractAddressHash)
//                      saveToFB(manifacturer: "Janssen", medicine: "PONVORY", fileName: "PONVORY-Spanish", country: "Spanish", flag: "🇪🇸", nomer: 0, hash: contractAddressHash )
//                        getProjectTitle()
//
//                    }) {
//                        Text("🇪🇸")
//                             .font(.largeTitle)
//                             .foregroundColor(.orange)
//                    }.offset(x: 20)
//                }
//  край на  HStack от бутони той е само за вьвеждане на данни
//  при демонстрация не трябва да го има

                ZStack {
                    VStack(alignment: .center, spacing: 20){
                        ForEach(models.models) { model in

                            HStack{
                                Button(action: {
                                        self.onSelect = true
                                        let stringUrl = models.getURL(model: model)
                                        contractAddressHash = model.hash

                                    if let url = NSURL(string: models.getURL(model: model)) {
                                        self.documentURL = url
                                        let data = NSData(contentsOf: NSURL(string: stringUrl) as! URL)
                                        self.dossihashedValue = "\(SHA256.hash(data: data! ))"
                                    print("dossihashedValue: ...\(dossihashedValue)")
                                        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
                                        contract = ProjectContract(wallet: wallet!, contract: model.hash)
                                    getProjectString(nomer: model.nomer) { str in
                                            print("srt:... \(str)")
                                            if str == self.dossihashedValue {

                                                self.isMedic = .pdfAction
                                            }else{
                                                self.showAlert = true
                                                onSelect = false
                                            }
                                        }
                                    }
//                                        self.documentURL = NSURL(string: models.getURL(model: model))
                                        let data = NSData(contentsOf: NSURL(string: stringUrl) as! URL)
                                        self.dossihashedValue = "\(SHA256.hash(data: data! ))"
                                    print("dossihashedValue: ...\(dossihashedValue)")
                                        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
                                    contract = ProjectContract(wallet: wallet!, contract: model.hash)
                                        getProjectString(nomer: model.nomer) { str in
                                            print("srt:... \(str)")
                                            if str == self.dossihashedValue {

                                                self.isMedic = .pdfAction
                                            }else{
                                                self.showAlert = true
                                                onSelect = false
                                            }
                                        }
                                }) {
                                    HStack{
                                        Text(model.flag).scaleEffect(2)
                                        Spacer()
                                        Text(model.country).font(.system(size: 12))
                                    }
                                }
                                .foregroundColor(Color.black.opacity(0.5))
                                .frame(width: 200, height: 25, alignment: .center)
                                .padding()
                                .background(Color.orange.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            }
                        }
                    }
                    if onSelect { ShadowedProgressViews() }
                }
//  MARK: - Scanar

                Spacer()
                Button(action: {
                    isShow = true
                    isMedic = .scanningAction

                }) {
                    Text("Find medical leaflet")
                        .font(.system(size: 27))
                        .frame(width: UIScreen.main.bounds.width / 1.4 , height: 20)
                        .foregroundColor(Color.black.opacity(0.4))
                        .padding()
                        .background(Color.orange.opacity(0.5))
                        .cornerRadius(15)
                }
                .padding(.bottom)
            }



//                Spacer()
//                Button(action: {
//                    // Create wallet using either a private key or mnemonic
//                    wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"metamask")
//                    // Create contract with wallet as the sender
//                    contract = ProjectContract(wallet: wallet!)
//                    // Call contract method
//                    createNewProject()
//                    getProjectTitle()
//                }) {
//                    Image(systemName: "paperplane.fill")
//                        .font(.largeTitle)
//                        .foregroundColor(.orange)
//                }

        }
        .onTapGesture {
            self.onSelect = false
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"),
                  message: Text("The pdf file is not legitimate."),
                  dismissButton: .default(Text("Done"), action: {
                  }))
        }

        .sheet(item: $isMedic)  { medic in
            switch medic {
            case .scanningAction:  ScannerView( scanningText: $scanningText)
            case .pdfAction: PDFKitView(url: documentURL! as URL).onAppear(){onSelect = false}
            case .firebase: ProgressView()
            }
        }

//        .onAppear(){
//            self.models.loadCountry(company: self.company, medicine: self.medicine)
//        }

    }

//    func loadUrlFromFirebase() {
//        let fileRef     = Storage.storage().reference().child("nebilet.pdf")
//        fileRef.downloadURL {( url , err ) in
//            if let downloadUrl = url {
//                self.documentURL = NSURL(string: scanningText)
//            }
//        }
//    }

    func saveToFB(manifacturer: String, medicine: String, fileName: String, country: String, flag: String, nomer: Int, hash : String) {

        let path = Bundle.main.path(forResource: fileName, ofType: "pdf")
        let filePathURL = URL(fileURLWithPath: path!)
        let fileREF = Storage.storage().reference().child("\(manifacturer)/\(fileName)")

        do{
            let _ = try! fileREF.putFile( from: filePathURL , metadata: nil) { (metadata , error ) in

                guard let metadata = metadata else {
                    print("error metadada ...\n \(error?.localizedDescription)")
                    return
                }
                let size = metadata.size
                DispatchQueue.main.async { [self] in
                    fileREF.downloadURL{ (url , err) in
                        guard let downloadURL = url else {
                            print("error >>:: \(err?.localizedDescription)")
                            return
                        }
                        do{
                            let data = try  NSData(contentsOf: downloadURL)

                            let hashedValue = SHA256.hash(data: data! )
                            print("Hashed Value: \(hashedValue)")
                            createNewProject( hashedValue: hashedValue, downloadURL: downloadURL.relativeString)
                        }catch{ print("no  > Hashed Value")}

                        saveModelToFB(manifacturer: manifacturer, medicine:  medicine, downloadURL: downloadURL.relativeString, country: country, flag: flag, nomer: nomer, hash: hash)
                    }
                }

            }

        }catch{

        }
    }



    func saveModelToFB(manifacturer: String, medicine: String, downloadURL: String,  country: String, flag: String, nomer : Int, hash : String){

        let moselToSave = Country(country: country, flag: flag, urlToFile: downloadURL, name: medicine, hash: hash, nomer: nomer)
        let db = Firestore.firestore()

        do{
            let _ = try db.collection("\(manifacturer)").addDocument(from: moselToSave)

        }catch{
            print("No saved to Firestore.firestore()")
        }
    }



    func saveToFireBase(){

        let filename = "QRV"
        let filePath    = Bundle.main.url(forResource: filename, withExtension: "pdf")
        let fpath = Bundle.main.path(forResource: filename, ofType: "pdf")

        let filePathURL = URL(fileURLWithPath: fpath!)

        let fileRef     = Storage.storage().reference().child("ether/pdf")
        print("\(filePath)")
        do{
            let _ = try! fileRef.putFile( from: filePathURL , metadata: nil) { (metadata , error ) in

                guard let metadata = metadata else {
                    print("error 🇫🇷metadada ...\n \(error?.localizedDescription)")
                    return
                }
                let size = metadata.size

                DispatchQueue.main.async { [self] in
                    fileRef.downloadURL{( url , err ) in
                        guard let downloadURL = url else {
                            print("error .. >> url")
                            return
                        }
                        print("url >> \(downloadURL.relativeString)")
                        do{
                            let data = try  NSData(contentsOf: downloadURL)
                            print("data:>\(data)")
                            let hashedValue = SHA256.hash(data: data! )
                            print("Hashed Value: \(hashedValue)")
                            createNewProject( hashedValue: hashedValue, downloadURL: downloadURL.relativeString)
                        }catch{ print("no  > Hashed Value🇪🇸 🇬🇧 🇮🇹 🇫🇷 🇮🇱 🇷🇺 🇧🇬 🇨🇳")}

                    }
                }


            }
        }
        catch {
            print("error putData ...")
        }
    }

    func createNewProject( hashedValue: SHA256.Digest, downloadURL: String) {


        let projectStart = "\(downloadURL)"
        let projectEnd = "\(hashedValue)"

        let parameters = [projectStart,projectEnd] as [AnyObject]
        firstly {
            // Call contract method
            callContractMethod(method: .projectContract, parameters: parameters,password: "dakata_7b")
        }.done { response in
            // print out response
            print("createNewProject response \(response)")
            // Call out get projectTitle
            self.getProjectTitle()
        }
    }

    func getProjectTitle() {
        let parameters = [] as [AnyObject]
        firstly {
            // Call contract method
            callContractMethod(method: .getDate, parameters: parameters,password: nil)
        }.done { response in
            // print out response
            print("getProjectTitle response \(response)")
        }
    }

    func getProjectString(nomer: Int, onDossi: @escaping (String) -> Void){
        let parameters = [] as [AnyObject]

        firstly {
            // Call contract method
            callContractMethodDossi(nomer: nomer ,method: .getDate, parameters: parameters,password: nil) { str in
                print("Dossi ... \(str as String )")
//                self.dossi = String(str)
                   onDossi(str)

            }
        }.done { response in
            // print out response
            print("getProjectTitle response \(response)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

struct ContentView_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/)
    }
}



