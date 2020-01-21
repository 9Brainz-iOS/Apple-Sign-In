# Apple SignIn

This is easy to use demo about Apple SignIn with code held in one file and access in all other views. This demo is avaialble in Swift.


# What is Apple SignIn?

Sign in with Apple makes it easy for users to sign in to your apps and websites using their Apple ID. Instead of filling out forms, verifying email addresses, and choosing new passwords, they can use Sign in with Apple to set up an account and start using your app right away.


# Basic Config:

1. Xcode 11.0 or above
2. Swift 4.0 or above
3. Development Target 13.0 or above
4. Device Universal Supported


# How it Works?

You just need to download this demo and run it in REAL device. OR Just copy and paste code from ViewController.swift file into your projects and access it!

# Quick Use

Open your ViewController.swift file and Follow below steps:

**1. Setup Apple SignIn Button**

```swift
func setupAppleSignInButton()
{
     let objASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton()
     objASAuthorizationAppleIDButton.frame = CGRect(x: 20, y: (UIScreen.main.bounds.size.height - 70), width: (UIScreen.main.bounds.size.width - 40), height: 50)
     objASAuthorizationAppleIDButton.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
     self.view.addSubview(objASAuthorizationAppleIDButton)
}
```

**2. Button Click Action Handler**

```swift
@objc func actionHandleAppleSignin()
{
     let appleIDProvider = ASAuthorizationAppleIDProvider()
     
     let request = appleIDProvider.createRequest()
     request.requestedScopes = [.fullName, .email]
     
     let authorizationController = ASAuthorizationController(authorizationRequests: [request])
     authorizationController.delegate = self
     authorizationController.presentationContextProvider = self     
     authorizationController.performRequests()
}
```

**3. Authorization Completion Handler**

```swift
func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization)
{
     switch authorization.credential { 
     
     case let credentials as ASAuthorizationAppleIDCredential:
          DispatchQueue.main.async {
          
          print(“################“)
          print(“User ID: \(credentials.user)")
          print(“Email: \(credentials.email!)")
          print(“First Name: \(credentials.fullName!.givenName!)”)
          print(“Last Name: \(credentials.fullName!.familyName!)")
          print(“################“)
          }
            
     case let credentials as ASPasswordCredential:
            DispatchQueue.main.async {
            
            print(“################“)
            print(“User ID: \(credentials.user)")
            print(“Password: \(credentials.password)")
            print(“################“)
            }
            
     default :
             DispatchQueue.main.async {
             
             print(“################“)
             print(“Something went wrong! Try again.”)
             print(“################“)
             }
     break
    }
 }
```

**4. Check Apple SignIn Status**

```swift
func checkStatusOfAppleSignIn() 
{
     let appleIDProvider = ASAuthorizationAppleIDProvider()
     appleIDProvider.getCredentialState(forUserID: "\(UserDefaults.standard.value(forKey: "User_AppleID")!)") { (credentialState, error) in
     
     switch credentialState {
     
     case .authorized:
          // Do your things.
          break
      
      default:
           break
          }
       }
}
```

This is it! You can easily put this code in your project and test it! But, If you want proper code with handling and display urser's data. Click to **Clone or Download** and check our code.

# License

This line of codes are avaialble for public use by [**9Brainz**](https://www.9brainz.com). If you have any doubts or query regarding this code or any particular topic reagrding iOS Application development, Feel free to [**Contact Us**](https://9brainz.com/contact-us.html).

# Helpful!!

Is this demo helpful for your project? OR Reducing tiny bit of work in your project?
Let us know about it 🔥🔥🔥

