# Extension 예제

CLOVA를 통해 서비스되고 있는 일부 extension을 소개합니다. 간단한 동작을 수행하는 extension으로서 extension을 구현할 때 도움이 될만한 예제입니다.

* [마법 구슬(Magic ball)](#MagicBall)
* [빗소리(Rain sound)](#RainSound)
* [주사위 놀이(Dice drawer)](#DiceDrawer)
* [코인 헬퍼(Coin helper)](#CoinHelper)

## 마법 구슬(Magic ball) {#MagicBall}

마법 구슬은 사용자의 물음에 미리 정의해놓은 20 가지의 긍정 또는 부정 표현 중 하나를 응답으로 돌려주는 extension입니다.

### 특징
* 사용자의 발화와 관계없이 응답을 선택해서 내려주기 때문에 interaction 모델이 간단합니다.
* 서버 클라이언트 프로그래밍으로 보면 "echo" 수준의 예제라고 할 수 있습니다.
* Go 언어로 구현되어 있습니다.

### GitHub 저장소
{{ book.ServiceEnv.GitHubBaseURIforExtensionExample }}/clova-extension-sample-magicball

## 빗소리(Rain sound) {#RainSound}

빗소리는 사용자의 요청에 미리 녹음해둔 빗소리 음원 파일(.mp3)를 클라이언트가 재생하도록 응답하는 extension입니다.

### 특징
* 사용자는 빗소리를 몇 번 반복해서 들을지 결정할 수 있으며, 이 extension의 interaction 모델은 반복 횟수에 대한 값을 slot으로 정의하고 있습니다.
* 클라이언트가 음원을 재생할 수 있도록 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtRequestType)에 안내 문구 뿐만 아니라 [`AudioPlayer.Play`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#Play) 지시 메시지를 포함시켜 CEK로 보내줍니다.
* Node.js로 구현되어 있습니다.

### GitHub 저장소
{{ book.ServiceEnv.GitHubBaseURIforExtensionExample }}/clova-extension-sample-rainsound

## 주사위 놀이(Dice drawer) {#DiceDrawer}

주사위 놀이는 사용자의 요청에 가상의 주사위를 굴려 나온 주사위의 눈과 눈의 합계를 알려주는 extension입니다.

### 특징
* 사용자는 주사위를 몇 개 던질 지 결정할 수 있으며, 이 extension의 interaction 모델은 주사위 개수에 대한 값을 slot으로 정의하고 있습니다.
* 굴릴 주사위 개수가 하나인지 두 개 이상 인지에 따라 응답으로 돌려주는 표현이 달라집니다.
* Node.js로 구현되어 있습니다.

### GitHub 저장소
{{ book.ServiceEnv.GitHubBaseURIforExtensionExample }}/clova-extension-sample-dice

## 코인 헬퍼(Coin helper) {#CoinHelper}

코인 헬퍼는 사용자의 요청에 외부 가상 화폐 거래소에서 제공하는 REST API를 호출하여 시세 정보를 돌려주는 extension입니다.

### 특징
* 사용자는 어떤 거래소의 정보를 이용할지 어떤 가상화폐의 시세를 조회할지 결정할 수 있으며, 이 extension의 interaction 모델은 거래소와 가상 화폐 종목에 대한 값을 slot으로 정의하고 있습니다.
* 외부 서비스의 REST API를 이용하여 다른 서비스로부터 데이터를 조회합니다.
* 다른 예제보다 조금 더 복잡한 interaction 모델을 가지고 있습니다.
* Go 언어로 구현되어 있습니다.

### GitHub 저장소

{{ book.ServiceEnv.GitHubBaseURIforExtensionExample }}/clova-extension-sample-coinhelper
