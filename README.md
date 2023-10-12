# Web Timer iOS

I enjoy listening to radio stations from all around the world, or even just locally. I like to work to it, fall asleep to it, walk to it. I enjoy starting a stream and walking away from my phone or computer. While some streaming stations have apps that contains timers, most don't. (It's such a simple feature to implement, it makes me wonder if it's less a laziness and more just a dark pattern or business logic.) I also don't like having to download an app just to stream from a website. But I love having an auto-shutoff feature.

I decided to solve this problem by building my own iOS app. On launch, you can type in a web address or choose from a list of your five most recently used web addresses. You can use the picker to choose a time and tap the start button, or you can just tap one of three start presets. The website opens in a modal and you can manually start the stream. The modal will close when the countdown timer runs out (shown in upper right), or you can end early using the close button. Simple. There is also a dark mode, for night-time use.

Current Status: This was a pretty quick build. (Design & development in one weekend.) It's working as expected, and I do use it quite a bit. That said, the more I use it, the more I'm seeing ways in which the UX/UI can be improved. I'll iterate further on this, before perhaps considering releasing to the App store.

Xcode, Swift, WebKit
