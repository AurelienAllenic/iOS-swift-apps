import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var login: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.5)

                VStack(alignment: .leading) {
                    if !viewModel.isValid {
                        VStack {
                            Text("Login")
                                .foregroundColor(.black)
                                .font(.title.weight(.bold))

                            TextField("Login", text: $login)
                                .frame(width: 246, height: 44)
                                .background(.white)
                                .cornerRadius(3)
                                .padding(.bottom, 0)
                                

                            SecureField("Password", text: $password)
                                .frame(width: 246, height: 44)
                                .background(.white)
                                .cornerRadius(3)
                                .padding(.bottom, 10)

                            Button {
                                viewModel.checkConnection(login: login, password: password)
                            } label: {
                                Text("Submit")
                                    .padding(10)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                            }
                        }
                        .padding()
                    } else {
                        Text("Connecté !")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 500, height: 100, alignment: .center)

                        NavigationLink(destination: MenuAppsView()) {
                            Text("Menu")
                                .padding()
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .frame(width: 500, height: 100, alignment: .center)
                        }
                        .padding(.top)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear{
                viewModel.isValid = false
            }
        }
    }
}

#Preview {
    MainView()
}
