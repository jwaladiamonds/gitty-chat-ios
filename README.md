# gitty-chat-ios

[![Join the chat at https://gitter.im/Gitter-iOS-App/community](https://badges.gitter.im/Gitter-iOS-App/community.svg)](https://gitter.im/Gitter-iOS-App/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

 Gitty Chat iOS App using Gitter API

#### Prerequesties:

- Xcode 12+
- MacOS 11+

## Getting started

```
git clone git@github.com:jwaladiamonds/gitty-chat-ios.git
cd gitty-chat-ios
``` 

Go to https://developer.gitter.im/apps and create a new App. 

Now you need to create a file `Secret.swift` inside `GittyChat/Resources` using a text editor before starting Xcode and add the following code and replace the string values with infromation of the app created in developer site:

```
struct OAuth {
	let key = "OAUTH KEY"
	let secret = "OAUTH SECRET"
	let redirect = "REDIRECT URL"
}
```

Once you save the file, you can open the project in Xcode.

## Contribute

Feel free to send PR to `main` branch. Feature list and progress in marked in the [TODO List](TODO.md).

License: MIT