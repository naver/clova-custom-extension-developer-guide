# 오디오 콘텐츠 제공하기

Custom extension을 통해 사용자에게 음악이나 podcast와 같은 오디오 콘텐츠를 제공할 수 있습니다. 이를 위해 [Custom extension 메시지](/Develop/References/Custom_Extension_Message.md)의 [`EventRequest`](/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest) 타입의 요청 메시지와 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage) 명세에서 클라이언트(사용자 기기나 CLOVA 앱)용 메시지 포맷인 오디오 콘텐츠 재생 관련 [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }})를 활용해야 합니다. 오디오 콘텐츠를 사용자에게 제공하려면 다음에 해당하는 내용을 extension에 구현해야 하며, 각 절에서는 구체적인 설명을 다룹니다. **특히, 필수 구현 항목은 반드시 구현해야 합니다.**

* 필수 구현
  * [오디오 콘텐츠 재생 지시](#DirectClientToPlayAudio)
  * [오디오 콘텐츠 재생 제어](#ControlAudioPlayback)
  * [오디오 콘텐츠의 메타 정보 제공](#ProvidingMetaDataForDisplay)

* 선택 구현
  * [재생 상태 변경 및 경과 보고 수집](#CollectPlaybackStatusAndProgress)
  * [보안을 위한 오디오 콘텐츠 URI 갱신](#UpdateAudioURIForSecurity)
  * [재생 제어의 동작 방식 변경](#CustomizePlaybackControl)

<div class="note">
  <p><strong>Note!</strong></p>
  <p>오디오 콘텐츠를 재생하는 custom extension을 구현하려면 <a href="/DevConsole/Guides/Register_Custom_Extension.md">CLOVA developer console에 extension을 등록</a>할 때 <a href="/DevConsole/Guides/Register_Custom_Extension.md#InputExtensionInfo">기본 정보</a>로 {{ book.DevConsole.cek_audioplayer }} 항목을 <strong>네</strong>로 선택해야 합니다.</p>
</div>

<div class="note">
  <p><strong>Note!</strong></p>
  <p>Custom extension을 통해 음성(TTS)나 오디오 콘텐츠를 음원 파일(.mp3)로 제공할 경우 HTTPS 방식으로 제공할 것을 권고합니다. CLOVA 플랫폼에서는 현재 HTTP 방식으로 음원 파일을 제공하는 것도 지원하고 있으나 언제든지 HTTPS 방식의 URI를 가진 음원 파일을 제공하도록 제한할 수 있습니다.</p>
</div>

## 오디오 콘텐츠 재생 지시 {#DirectClientToPlayAudio}

사용자가 음악이나 음악과 같은 방식으로 음원을 재생하도록 요청하면 해당 오디오 콘텐츠를 사용자의 클라이언트에 전달해야 합니다. 사용자의 음원 재생 요청이  [`IntentRequest`](/Develop/References/Custom_Extension_Message.md#CustomExtIntentRequest) 타입의 요청 메시지로 custom extension에 전달될 것이며, custom extension은 해당 `IntentRequest` 타입의 요청 메시지에 대한 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)를 보내야 합니다. 이때, 이 메시지에 클라이언트가 오디오 콘텐츠를 재생하도록 지시하는 [`AudioPlayer.Play`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#Play) 지시 메시지(클라이언트 제어용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}))를 포함시키면 됩니다.

<div class="note">
  <p><strong>Note!</strong></p>
  <p>제공하려는 오디오 콘텐츠는 <a href="/Design/Supported_Audio_Format.md">플랫폼이 지원하는 오디오 압축 포맷</a>이어야 합니다.</p>
</div>

<div class="note">
  <p><strong>Note!</strong></p>
  <p>재생 지시와 관련된 내용은 오디오 콘텐츠를 제공하는 custom extension의 메인 기능이며, 필수 구현 항목입니다.</p>
</div>

[`AudioPlayer.Play`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#Play) 지시 메시지의 명세를 확인하여 클라이언트에 전달해야 하는 음원 정보를 다음과 같이 custom extension의 응답 메시지에 포함합니다. 보유하고 있는 음원의 정보나 특징에 따라 작성해야 하는 필드와 음원의 정보가 달라질 수 있습니다.

```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "card": {},
    "directives": [
      {
        "header": {
          "namespace": "AudioPlayer",
          "name": "Play"
        },
        "payload": {
          "audioItem": {
            "audioItemId": "90b77646-93ab-444f-acd9-60f9f278ca38",
            "episodeId": 22346122,
            "stream": {
              "beginAtInMilliseconds": 419704,
              "progressReport": {
                "progressReportDelayInMilliseconds": null,
                "progressReportIntervalInMilliseconds": 60000,
                "progressReportPositionInMilliseconds": null
              },
              "token": "eyJ1cmwiOiJodHRwczovL2FwaS1leC5wb2RiYmFuZy5jb20vY2xvdmEvZmlsZS8xMjU0OC8yMjYxODcwMSIsInBsYXlUeXBlIjoiTk9ORSIsInBvZGNhc3RJZCI6MTI1NDgsImVwaXNvZGVJZCI6MjI2MTg3MDF9",
              "url": "https://streaming.example.com/clova/file/12548/22618701",
              "urlPlayable": true
            },
            "type": "podcast"
          },
          "source": {
            "name": "Potbbang",
            "logoUrl": "https://img.musicservice.example.net/logo_180125.png"
          },
          "playBehavior": "REPLACE_ALL"
        }
      }
    ],
    "outputSpeech": {},
    "shouldEndSession": true
  }
}
```

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p><a href="/Develop/Guides/Build_Custom_Extension.md#ReturnCustomExtensionResponse">응답 메시지로 반환</a>할 때 <code>response.outputSpeech</code> 필드도 함께 지정할 수 있습니다. 예를 들면 "요청하신 오디오를 들려드릴게요" 라는 음성 출력(TTS)을 먼저 사용자에게 들려준 후 오디오의 재생을 시작할 수 있습니다.</p>
</div>

<div class="note">
  <p><strong>Note!</strong></p>
  <p><a href="{{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}">CIC API</a> 지시 메시지</p>를 작성할 때 "포함여부"가 <strong>"항상"</strong>인 필드는 필수 항목이며, 반드시 작성해야 합니다.</p>
</div>

## 오디오 콘텐츠 재생 제어 {#ControlAudioPlayback}
사용자의 클라이언트가 오디오를 재생 중일 때 사용자가 "이전", "다음"과 같이 재생 제어와 관련된 발화를 하면 사용자의 요청이 `IntentRequest` 타입의 요청 메시지 형태로 custom extension에 전달될 수 있습니다. 현재 CLOVA는 custom extension으로 재생 제어와 관련된 사용자의 의도를 다음과 같은 [built-in intent](/Design/Design_Custom_Extension.md#BuiltinIntent)로 전달하고 있습니다.

* `Clova.NextIntent`
* `Clova.PauseIntent`
* `Clova.PreviousIntent`
* `Clova.RequestAlternativesIntent`
* `Clova.ResumeIntent`
* `Clova.StopIntent`

<div class="note">
  <p><strong>Note!</strong></p>
  <p>재생 제어와 관련된 내용은 필수 구현 항목입니다. 특히, <code>Clova.PauseIntent</code>와 <code>Clova.StopIntent</code> built-in intent에 대응하는 동작을 구현하지 않으면, 사용자에게 심각한 불편을 줄 수 있습니다.</p>
</div>

사용자가 "잠깐 멈춰", "다시 재생해", "중지 해줘"와 같이 발화하면, custom extension은 재생 일시 정지, 재생 재개, 재생 중지 요청에 대응해야 합니다. 이때, 클라이언트는 각각의 요청에 대해 `Clova.PauseIntent`, `Clova.ResumeIntent`, `Clova.StopIntent` built-in intent를 `IntentRequest` 타입 요청 메시지로 받게 됩니다. Custom extension은 이에 대응하여 각각 다음과 같은 지시 메시지(클라이언트 제어용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}))를 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)로 CLOVA에 전송해야 합니다.

* [`PlaybackController.Pause`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/PlaybackController.{{ book.DocMeta.FileExtensionForExternalLink }}#Pause) 지시 메시지: 클라이언트에 재생 중인 오디오 스트림을 일시 정지하도록 지시
* [`PlaybackController.Resume`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/PlaybackController.{{ book.DocMeta.FileExtensionForExternalLink }}#Resume) 지시 메시지: 클라이언트에 오디오 스트림 재생을 재개하도록 지시
* [`PlaybackController.Stop`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/PlaybackController.{{ book.DocMeta.FileExtensionForExternalLink }}#Stop) 지시 메시지: 클라이언트에 오디오 스트림 재생을 중지하도록 지시

다음은 `PlaybackController.Pause` 지시 메시지를 custom extension의 응답 메시지에 포함한 예입니다.
```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "card": {},
    "directives": [
      {
        "header": {
          "namespace": "PlaybackController",
          "name": "Pause"
        },
        "payload": {}
      }
    ],
    "outputSpeech": {},
    "shouldEndSession": true
  }
}
```

사용자가 "이전" 또는 "다음"에 해당하는 발화를 하여 `Clova.NextIntent` 혹은 `Clova.PreviousIntent` built-in intent를 `IntentRequest` 타입 요청 메시지로 받게 되면, 현재 재생 목록의 이전이나 다음 곡에 해당하는 [오디오 콘텐츠를 재생하도록 지시(`AudioPlayer.Play`)](#DirectClientToPlayAudio)하는 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)를 작성하면 됩니다.

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>만약, 이전이나 다음에 해당하는 오디오 콘텐츠가 없거나 유효하지 않으면 "재생할 수 있는 이전 또는 다음 곡이 없습니다."와 같은 음성 출력을 <a href="/Develop/Guides/Build_Custom_Extension.md#ReturnCustomExtensionResponse">응답 메시지로 반환</a>하면 됩니다.</p>
</div>

사용자가 "다른 거 들려줘"(`Clova.RequestAlternativesIntent`)에 해당하는 발화를 했다면 상황을 판단하여 응답하면 됩니다. 응답 유형은 다양할 수 있으며 다음은 `Clova.RequestAlternativesIntent` built-in intent에 대응하는 예입니다.
* 완전히 새로운 재생 목록의 [오디오 콘텐츠를 재생하도록 지시(`AudioPlayer.Play`)](#DirectClientToPlayAudio)하는 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)를 작성
* 비슷한 곳을 재생하도록 지시하는 응답 메시지를 작성
* 다음 곡을 재생하도록 지시하는 응답 메시지를 작성
* 사용자가 원하는 것이 무엇인지 구체적으로 파악하기 위해 [multi-turn 대화 시도](/Develop/Guides/Do_Multiturn_Dialog.md)
* 더 이상 제공할 수 있는 콘텐츠가 없거나 사용자의 요청을 들어줄 수 없을 때 [안내 음성(TTS) 제공](/Develop/Guides/Build_Custom_Extension.md#ReturnCustomExtensionResponse)


## 오디오 콘텐츠의 메타 정보 제공 {#ProvidingMetaDataForDisplay}

사용자의 클라이언트로 하여금 [오디오 콘텐츠의 재생을 지시](#DirectClientToPlayAudio)하는 [`AudioPlayer.Play`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#Play) 지시 메시지(클라이언트 제어용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}))에는 제목, 앨범, 아티스트, 가사와 같은 정보는 포함되어 있지 않습니다. 하지만, 사용자가 CLOVA 앱이나 화면이 있는 클라이언트 기기 사용하고 있다면 Custom extension은 클라이언트가 이런 정보를 표시할 수 있도록 메타 정보를 제공해야 합니다.

이를 위해 클라이언트는 오디오 콘텐츠에 대한 재생 메타 정보를 얻기 위해 [`TemplateRuntime.RequestPlayerInfo`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/TemplateRuntime.{{ book.DocMeta.FileExtensionForExternalLink }}#RequestPlayerInfo) 이벤트 메시지(클라이언트 요청 전달용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}))를 CLOVA에 전송합니다. 이때, 이벤트 메시지의 내용이 [`EventRequest`](/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest) 타입의 요청 메시지로 다음과 같이 전달됩니다. 참고로 아래 예는 `eJyr5lIqSSyITy4tKs4vUrJSUE` token을 가지는 콘텐츠를 기준으로 다음 10 곡에 대한 메타 정보를 클라이언트가 요청한 것을 의미합니다.

```json
{
  "context": {
    ...
  },
  "request": {
    "type": "EventRequest",
    "requestId": "e5464288-50ff-4e99-928d-4a301e083d41",
    "timestamp": "2017-09-05T05:41:21Z",
    "event": {
      "namespace": "TemplateRuntime",
      "name": "RequestPlayerInfo",
      "payload": {
        "token": "eJyr5lIqSSyITy4tKs4vUrJSUE",
        "range": {
          "after": 10
        }
      }
    }
  },
  "session": {
      "new": true,
      "sessionAttributes": {},
      "sessionId": "69b20cc1-9166-41f3-a2dd-85b70f8e0bf5"
  },
  "version": "1.0"
}
```

Custom extension은 응답 메시지를 통해 클라이언트가 요청한 콘텐츠의 메타 정보를 전송해야 합니다. 다음과 같이 [`TemplateRuntime.RenderPlayerInfo`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/TemplateRuntime.{{ book.DocMeta.FileExtensionForExternalLink }}#RenderPlayerInfo) 지시 메시지를 응답 메시지에 포함시켜 메타 정보를 전송합니다.

```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "card": {},
    "directives": [
      {
        "header": {
          "namespace": "TemplateRuntime",
          "name": "RenderPlayerInfo"
        },
        "payload": {
          "controls": [
            {
              "enabled": true,
              "name": "PLAY_PAUSE",
              "selected": false,
              "type": "BUTTON"
            },
            {
              "enabled": true,
              "name": "NEXT",
              "selected": false,
              "type": "BUTTON"
            },
            {
              "enabled": true,
              "name": "PREVIOUS",
              "selected": false,
              "type": "BUTTON"
            }
          ],
          "displayType": "list",
          "playableItems": [
            {
              "artImageUrl": "https://musicmeta.musicservice.example.com/example/album/662058.jpg",
              "controls": [
                {
                  "enabled": true,
                  "name": "LIKE_DISLIKE",
                  "selected": false,
                  "type": "BUTTON"
                }
              ],
              "headerText": "Classic",
              "lyrics": [
                {
                  "data": null,
                  "format": "PLAIN",
                  "url": null
                }
              ],
              "isLive": false,
              "showAdultIcon": false,
              "titleSubText1": "Alice Sara Ott, Symphonie Orchester Des Bayerischen Rundfunks, Esa-Pekka Salonen",
              "titleSubText2": "Wonderland - Edvard Grieg : Piano Concerto, Lyric Pieces",
              "titleText": "Grieg : Piano Concerto In A Minor, Op.16 - 3. Allegro moderato molto e marcato (Live)",
              "token": "eJyr5lIqSSyITy4tKs4vUrJSUE"
            },
            {
              "artImageUrl": "https://musicmeta.musicservice.example.com/example/album/202646.jpg",
              "controls": [
                {
                  "enabled": true,
                  "name": "LIKE_DISLIKE",
                  "selected": false,
                  "type": "BUTTON"
                }
              ],
              "headerText": "Classic",
              "lyrics": [
                {
                  "data": null,
                  "format": "PLAIN",
                  "url": null
                }
              ],
              "isLive": true,
              "showAdultIcon": false,
              "titleSubText1": "Berliner Philharmoniker, Herbert Von Karajan",
              "titleSubText2": "Mendelssohn : Violin Concerto; A Midsummer Night`s Dream",
              "titleText": "Symphony No.4 In A Op.90 'Italian' - III. Con Moto Moderato",
              "token": "eJyr5lIqSSyITy4tKs4vUrJSUEo2"
            },
            ...
          ],
          "provider": {
            "logoUrl": "https://img.musicservice.example.net/logo_180125.png",
            "name": "SampleMusicProvider",
            "smallLogoUrl": "https://img.musicservice.example.net/smallLogo_180125.png"
          }
        }
      }
    ],
    "outputSpeech": {},
    "shouldEndSession": true
  }
}
```

## 재생 상태 변경 및 경과 보고 수집 {#CollectPlaybackStatusAndProgress}

[`AudioPlayer.Play`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#Play) 지시 메시지(클라이언트 제어용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}))에 의해 오디오를 재생하는 사용자의 클라이언트는 재생의 시작, 일시 정지, 재개, 중지, 종료 시점에 다음과 같은 이벤트 메시지(클라이언트 요청 전달용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}))를 CLOVA에 전송합니다.

* [`AudioPlayer.PlayStarted`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayStarted)
* [`AudioPlayer.PlayPaused`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayPaused)
* [`AudioPlayer.PlayResumed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayResumed)
* [`AudioPlayer.PlayStopped`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayStopped)
* [`AudioPlayer.PlayFinished`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayFinished)

이때, CLOVA는 이 이벤트 메시지의 내용을 [`EventRequest`](/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest) 타입 요청 메시지로 custom extension에 전송합니다. 뿐만 아니라 클라이언트는 [오디오 콘텐츠를 재생하도록 지시(`AudioPlayer.Play`)](#DirectClientToPlayAudio) 받은 후 `AudioPlayer.Play` 지시 메시지의 `progressReport` 필드에 정의한 설정에 따라 재생 경과 보고를 하게 됩니다. 이 또한 [`EventRequest`](/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest) 타입 요청 메시지로 custom extension에 전송됩니다. 클라이언트는 다음과 같은 경과 보고용 이벤트 메시지를 전송합니다.

* [`AudioPlayer.ProgressReportDelayPassed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#ProgressReportDelayPassed) 이벤트 메시지: 재생 시작 후 특정 시간이 지난 후 재새 경과 보고
* [`AudioPlayer.ProgressReportPositionPassed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#ProgressReportPositionPassed) 이벤트 메시지: 오디오 콘텐츠의 특정 위치(offset)를 재생할 때 경과 보고
* [`AudioPlayer.ProgressReportIntervalPassed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#ProgressReportIntervalPassed) 이벤트 메시지: 재생 중인 상황에서 특정 주기로 반복하여 경과 보고

다음은 `EventRequest` 타입 요청 메시지를 통해 전달된 보고의 예입니다.
```json

{
  "context": {
    "AudioPlayer": {
      "offsetInMilliseconds": 60000,
      "playerActivity": "STOPPED",
      "stream": {
        "token": "TR-NM-17413540",
        "url": "https://music.serviceprovider.example.net/content?id=17413540",
        "urlPlayable": true
      },
      "totalInmillisecodns": 300000
    },
    "System": "{ ... }"
  },
  "request": {
    "type": "EventRequest",
    "requestId": "e5464288-50ff-4e99-928d-4a301e083d41",
    "timestamp": "2017-09-05T05:41:21Z",
    "event": {
      "namespace": "AudioPlayer",
      "name": "PlayStopped",
      "payload": {}
    }
  },
  "session": {
    "new": true,
    "sessionAttributes": {},
    "sessionId": "69b20cc1-9166-41f3-a2dd-85b70f8e0bf5"
  },
  "version": "1.0"
}
```

위 `EventRequest` 타입 요청 메시지는 클라이언트가 총 5 분짜리 오디오 콘텐츠에서 1 분이되는 시점에 재생을 중지한 것을 보고하고 있습니다. 이와 같이 custom extension은 클라이언트의 재생 상태 변화를 추적할 수 있습니다. 예를 들면, `AudioPlayer.PlayStopped`와 `AudioPlayer.PlayFinished` 이벤트 메시지 정보가 포함된 `EventRequest` 타입 요청 메시지를 수집하여 오디오를 끝까지 듣거나 듣지 않는 사용자를 구분하고 이를 통계 데이터로 만들 수 있습니다.

또, `AudioPlayer.ProgressReportIntervalPassed` 이벤트 메시지가 포함된 `EventRequest` 타입 요청 메시지를 이용하여 완전히 정확한 것은 아니지만 사용자가 오디오 콘텐츠를 어디까지 들었는지 파악할 수 있습니다. 만약, 사용자가 다음 번에 같은 오디오 콘텐츠에 대한 재생을 요청하면 이 데이터를 기반으로 마지막으로 들었던 위치부터 재생할 수 있습니다.

<div class="note">
  <p><strong>Note!</strong></p>
  <p>재생 상태 보고와 관련된 <code>EventRequest</code> 타입 요청 메시지 중 <code>AudioPlayer.PlayFinished</code> 이벤트 메시지 정보가 포함된 메시지를 받으면 custom extension은 재생 완료에 대한 클라이언트의 다음 동작을 응답 메시지로 전달해야 합니다. 이와 관련된 동작으로 다음 <a href="#DirectClientToPlayAudio">오디오 콘텐츠 재생을 지시</a>할 수도 있고 재생 중지와 같은 <a href="#ControlAudioPlayback">재생 제어</a>를 지시할 수도 있습니다.</p>
</div>

참고로 이 절에서 언급한 `AudioPlayer` 네임스페이스 이벤트 메시지에는 `AudioPlayer.PlaybackState` 문맥 정보(context)가 첨부됩니다. 이 정보 역시 `EventRequest` 타입 요청 메시지가 전송될 때 함께 첨부되므로, custom extension은 첨부된 [`AudioPlayer.PlaybackState`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/Context_Objects.{{ book.DocMeta.FileExtensionForExternalLink }}#PlaybackState) 문맥 정보로부터 오디오 콘텐츠의 ID, 재생 상태, 오디오 콘텐츠의 재생 위치와 같은 것을 파악할 수 있습니다.

다음은 `AudioPlayer.PlaybackState` 문맥 정보가 전달된 예입니다.
```json
{
  "offsetInMilliseconds": 5077,
  "playerActivity": "PLAYING",
  "stream": {
    "token": "TR-NM-17413540",
    "url": "https://musicservice.example.net/content?id=17413540",
    "urlPlayable": true
  },
  "totalInMilliseconds": 195265
}
```

## 보안을 위한 오디오 콘텐츠 URI 갱신 {#UpdateAudioURIForSecurity}

Custom extension이 사용자의 클라이언트에 [오디오 콘텐츠 재생을 지시](#DirectClientToPlayAudio)할 때 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)에 [`AudioPlayer.Play`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#Play) 지시 메시지(클라이언트 제어용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }})를 포함시켜야 합니다. 이때, `AudioPlayer.Play` 지시 메시지의 `audioItem.stream.url` 필드에 오디오 콘텐츠를 재생시킬 수 있는 URI를 입력하여 전달하게 됩니다.

다만, 서비스 제공자에 따라 보안 이슈로 영구적으로 유효한 URI를 첨부하기 어려울 수 있습니다. 예를 들면, 이 URI가 노출된다면 콘텐츠를 획득하기 위한 공격이 발생할 수도 있을 것입니다. 따라서 짧은 만료 기간을 가진 인스턴스 URI를 많이 사용는 편입니다. 또한, 클라이언트가 `AudioPlayer.Play` 지시 메시지를 받았더라도 그보다 우선 순위가 높거나 먼저 시작된 작업 또는 네트워크 상황에 의해 오디오 콘텐츠의 재생 시작이 지연될 수도 있습니다. 이때 URI 유효 기간이 만료되어 오디오 콘텐츠를 제대로 재생할 수 없을 수도 있습니다.

이를 위해 CLOVA는 클라이언트가 오디오 콘텐츠의 재생 가능한 URI를 재생 직전에 취득할 수 있도록 하는 방법을 제공하고 있습니다. 우선 다음과 같이 `AudioPlayer.Play` 지시 메시지 중 `urlPlayable` 필드를 `false`로 지정하고, `url` 필드에 URI가 아닌 다른 형식의 값을 입력합니다.

```json
{
  "audioItem": {
    "audioItemId": "9CPWU-c82302b2-ea29-4f6c-ba6e-20fd268d8c3b-c1570067",
    "title": "Symphony No.4 In A Op.90 'Italian' - III. Con Moto Moderato",
    "artist": "Unknown",
    "stream": {
      "beginAtInMilliseconds": 0,
      "progressReport": {
        "progressReportDelayInMilliseconds": null,
        "progressReportIntervalInMilliseconds": null,
        "progressReportPositionInMilliseconds": 60000
      },
      "token": "TR-NM-17413540",
      "url": "clova:TR-NM-17413540",
      "urlPlayable": false
    }
  },
  "playBehavior": "REPLACE_ALL"
}
```

나중에 클라이언트가 `AudioPlayer.Play` 지시 메시지를 수행할 때 `urlPlayable` 필드가 `false`이면, 유효한 오디오 콘텐츠의 URI를 얻기 위해 [`AudioPlayer.StreamRequested`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#StreamRequested) 이벤트 메시지(클라이언트 요청 전달용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}))를 CLOVA에 전송하게 됩니다. 이때, 이벤트 메시지의 내용이 [`EventRequest`](/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest) 타입의 요청 메시지로 다음과 같이 전달됩니다.

```json
{
  "context": {
    ...
  },
  "request": {
    "type": "EventRequest",
    "requestId": "e5464288-50ff-4e99-928d-4a301e083d41",
    "timestamp": "2017-09-05T05:41:21Z",
    "event": {
      "namespace": "AudioPlayer",
      "name": "StreamRequested",
      "payload": {
        "audioItemId": "9CPWU-c82302b2-ea29-4f6c-ba6e-20fd268d8c3b-c1570067",
        "title": "Symphony No.4 In A Op.90 'Italian' - III. Con Moto Moderato",
        "artist": "Unknown",
        "stream": {
          "beginAtInMilliseconds": 0,
          "progressReport": {
            "progressReportDelayInMilliseconds": null,
            "progressReportIntervalInMilliseconds": null,
            "progressReportPositionInMilliseconds": 60000
          },
          "token": "TR-NM-17413540",
          "url": "clova:TR-NM-17413540",
          "urlPlayable": false
        }
      }
    }
  },
  "session": {
    "new": true,
    "sessionAttributes": {},
    "sessionId": "69b20cc1-9166-41f3-a2dd-85b70f8e0bf5"
  },
  "version": "1.0"
}
```

Custom extension은 이 시점에 재생 가능한 오디오 콘텐츠의 URI를 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)로 전달하면 됩니다. 이를 위해 `AudioPlayer.StreamDeliver` 지시 메시지를 응답 메시지에 포함시켜야 합니다. 클라이언트는 다음과 같은 `AudioPlayer.StreamDeliver` 지시 메시지의 본문을 통해 `AudioPlayer.Play` 지시 메시지에 대한 작업을 마저 수행할 수 있게 됩니다.

```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "card": {},
    "directives": [
      {
        "header": {
          "namespace": "AudioPlayer",
          "name": "StreamDeliver"
        },
        "payload": {
          "audioItemId": "5313c879-25bb-461c-93fc-f85d95edf2a0",
          "stream": {
            "token": "b767313e-6790-4c28-ac18-5d9f8e432248",
            "url": "https://musicservice.example.net/b767313e.mp3"
          }
        }
      }
    ],
    "outputSpeech": {},
    "shouldEndSession": true
  }
}
```

## 재생 제어의 동작 방식 변경 {#CustomizePlaybackControl}

음원을 제공하는 서비스나 음원 콘텐츠의 특징에 따라서 재생 일시 정지, 재생 재개, 재생 중지와 같은 [재생 제어](#ControlAudioPlayback) 동작을 조금 다른 방식으로 구현해야 할 수도 있습니다. 예를 들면, 실시간 스트리밍 콘텐츠는 일시 정지 기능을 적용하는 것이 불가능할 수도 있습니다. 이때 사용자의 요청에 의해 `Clova.PauseIntent` [built-in intent](/Design/Design_Custom_Extension.md#BuiltinIntent) 요청을 받았더라도 그에 대한 대응을 처리하지 못한다고 응답하거나 또는 `Clova.StopIntent`와 같은 대응을 처리해줄 수도 있습니다. `Clova.StopIntent`와 같은 대응을 처리한다면 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)에 [`PlaybackController.Pause`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/PlaybackController.{{ book.DocMeta.FileExtensionForExternalLink }}#Pause) 지시 메시지(클라이언트 제어용 메시지, [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }})) 대신에 [`PlaybackController.Stop`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/PlaybackController.{{ book.DocMeta.FileExtensionForExternalLink }}#Stop) 지시 메시지를 응답으로 반환하도록 구현할 수 있습니다.

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>사용자의 혼란을 막기 위해 실시간 스트리밍 콘텐츠와 같이 특수한 상황에만 재생 제어의 동작 방식을 변경하고 되도록이면 기본 방식으로 구현할 것을 권장합니다.</p>
</div>
