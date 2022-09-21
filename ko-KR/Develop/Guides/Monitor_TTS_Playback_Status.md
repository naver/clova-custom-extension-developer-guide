# 음성 재생 상태 확인하기

[Custom extension에서 응답을 반환](/Develop/Guides/Build_Custom_Extension.md#ReturnCustomExtensionResponse)할 때 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)에서 [SpeechInfoObject](/Develop/References/Custom_Extension_Message.html#CustomExtSpeechInfoObject)의 `token` 필드를 입력하면 클라이언트에서 음성(TTS) 재생에 대한 경과를 보고 받을 수 있습니다. 이는 주로 클라이언트가 자막 또는 특정 콘텐츠를 표시할 때 음성 자막과 그 진행 단계를 맞추도록 할 때 사용할 수 있습니다.

예를 들면, "Hi, my name is CLOVA."와 같은 음성과 텍스트를 표시한 후 그 다음에 "How can I help you?"와 같은 텍스트를 표시한다고 가정해 봅니다. 이때, "Hi, my name is CLOVA"에 해당하는 음성을 재생하도록 전달한 후 해당 음성 재생이 완료된 다음에 그 다음 자막이 표시되도록 만들어야 합니다.

클라이언트가 위 동작을 정확하게 처리한다고 보장할 수 없기 때문에 첫 번째 음성이 재생되었음을 클라이언트로부터 보고 받고 난 후 그 다음 음성에 해당하는 자막과 음성을 전달해야 합니다. 이를 위해 첫 번째 음성에 대한 응답 메시지로 다음과 같이 `outputSpeech.values.token` 필드를 사용하여 음성(TTS)에 대한 token 값을 전달할 수 있습니다.

```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "outputSpeech": {
      "type": "SimpleSpeech",
      "values": {
          "type": "PlainText",
          "lang": "en",
          "token": "19d33bae-6cd5-4534-b0a3-e0036b4742bd",
          "value": "Hi, my name is CLOVA."
      }
    },
    "card": {},
    "directives": [
      {
        "directive": {
          "header": {
            "namespace": "Clova",
            "name": "RenderTemplate",
          },
          "payload": {
            {
              ...
              "paragraphText": {
                "type": "string",
                "value": "Hi, my name is CLOVA."
              },
              ...
              },
              "type": "Text"
            }
          }
        }
      }
    ],
    "shouldEndSession": false
  }
}
```

클라이언트는 각 상황에 맞는 [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }})를 사용하여 CLOVA에 음성(TTS) 재생에 대한 경과 보고를 하게 됩니다.

* [`SpeechSynthesizer.SpeechFinished`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechSynthesizer.{{ book.DocMeta.FileExtensionForExternalLink }}#SpeechFinished) 지시 메시지: 클라이언트에 재생 중인 오디오 스트림을 일시 정지하도록 지시
* [`SpeechSynthesizer.SpeechStarted`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechSynthesizer.{{ book.DocMeta.FileExtensionForExternalLink }}#SpeechStarted) 지시 메시지: 클라이언트에 오디오 스트림 재생을 재개하도록 지시
* [`SpeechSynthesizer.SpeechStopped`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechSynthesizer.{{ book.DocMeta.FileExtensionForExternalLink }}#SpeechStopped) 지시 메시지: 클라이언트에 오디오 스트림 재생을 중지하도록 지시

CLOVA는 그 보고를 [`EventRequest` 요청 타입](/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest) 메시지를 통해 extension에 전달합니다. 다음은 위 음성에 대해 재생 종료 보고를 받은 예입니다. 아래와 같은 메시지를 받은 후 현재 클라이언트의 음성 재생 상태를 확인하여 다음에 전달할 음성이나 콘텐츠를 응답으로 제공하는 방식으로 콘텐츠 제공 속도나 단계를 조절하면 됩니다.

```json
{
  "version": "0.1.0",
  "session": {
    ...
  },
  "context": {
    ...
  },
  "request": {
    "type": "EventRequest",
    "requestId": "cdb56a98-e940-4ee4-96eb-4f1cb3f97694",
    "timestamp": "2017-09-05T05:41:21Z",
    "event": {
      "namespace": "SpeechSynthesizer",
      "name": "SpeechFinished",
      "payload": {
        "token": "19d33bae-6cd5-4534-b0a3-e0036b4742bd"
      }
    }
  }
}
```
