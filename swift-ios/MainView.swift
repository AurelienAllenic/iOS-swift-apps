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
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .overlay(
                        VStack(alignment: .leading) {
                            if !viewModel.isValid {
                                VStack {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .font(.title.weight(.bold))

                                    TextField("Login", text: $login, prompt:
                                    Text("Your name ...")
                                        .foregroundColor(.black)
                                        .font(.title3.weight(.thin))
                                    )
                                        .padding()
                                        .frame(width: 246, height: 44)
                                        .background(.white)
                                        .cornerRadius(3)
                                        .autocapitalization(.none)
                                        .padding(.bottom, 10)
                                        .italic()

                                    SecureField("Password", text: $password, prompt:
                                        Text("Your password  ...")
                                            .foregroundColor(.black)
                                            .font(.title3.weight(.thin))
                                            .italic()
                                        )
                                        .padding()
                                        .frame(width: 246, height: 44)
                                        .background(.white)
                                        .cornerRadius(3)
                                        .padding(.bottom, 20)

                                    Button {
                                        viewModel.checkConnection(login: login, password: password)
                                    } label: {
                                        Text("Submit")
                                            .padding(10)
                                            .background(Color.black)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                            .font(.title2)
                                            .frame(maxWidth: .infinity, maxHeight: 50)
                                    }
                                }
                                .padding()
                            } else {
                                Text("Connecté !")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 500, height: 100, alignment: .center)
                                    .background(Color.black.opacity(0.4))

                                NavigationLink(destination: MenuAppsView()) {
                                    Text("Menu")
                                        .padding()
                                        .background(.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .frame(width: 500, height: 100, alignment: .center)
                                        .font(.title2.weight(.semibold))
                                }
                                .padding(.top)
                            }
                        }
                        .padding()
                    )
            }
            .onAppear {
                viewModel.isValid = false
            }
        }
    }
}

#Preview {
    MainView()
}
