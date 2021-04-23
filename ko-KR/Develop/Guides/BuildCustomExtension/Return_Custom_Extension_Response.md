## Custom extension 응답 반환하기 {#ReturnCustomExtensionResponse}
[요청 메시지를 처리](#HandleCustomExtensionRequest)하고 나면 다시 CEK로 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)를 돌려줘야 합니다(HTTP Response). 요청 메시지의 타입에 따라 응답해야 하는 내용이 달라질 수 있지만 응답 메시지의 구조는 크게 다르지 않습니다. 다음은 LaunchRequest 타입 요청("피자봇 시작해줘"라는 사용자 요청)을 처리하고 보낸 응답 메시지입니다.

{% raw %}
```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "outputSpeech": {
      "type": "SimpleSpeech",
      "values": {
          "type": "PlainText",
          "lang": "ko",
          "value": "안녕하세요, 피자봇입니다. 무엇을 도와드릴까요?"
      }
    },
    "card": {},
    "directives": [],
    "shouldEndSession": false
  }
}
```
{% endraw %}

각 필드는 다음과 같은 의미를 가집니다.

* `version`: 현재 사용하는 custom extension 메시지 포맷의 버전이 v0.1.0입니다.
* `response.outputSpeech`: 사용자에게 영어로 "Hi, nice to meet you"의 문장을 말하도록 설정합니다.
* `response.card`: 클라이언트 화면에 표시할 데이터가 없습니다. [Content template]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/Content_Templates.{{ book.DocMeta.FileExtensionForExternalLink }}) 형태의 데이터이며, 클라이언트 화면에 표시할 콘텐트를 이 필드를 통해 전달할 수 있습니다.
* `response.shouldEndSession`: 세션을 종료하지 않고 계속 사용자의 입력을 받습니다. 만약 이 필드 값이 true이면 [`SessionEndedRequest`](#HandleSessionEndedRequest) 요청을 받기 전에 extension이 주도하여 세션을 종료할 수 있습니다.

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p><code>sessionAttributes</code> 필드는 확장을 위해 예약해 둔 필드이며, <code>response.directives</code> 필드는 extension이 CEK로 전달하는 지시 메시지입니다. <code>response.directives</code> 필드에서 사용할 지시 메시지는 추후 API를 제공할 예정입니다.</p>
</div>

다음과 같이 상황에 따라서 여러 문장을 출력하도록 응답 메시지를 작성할 수도 있고, 인터넷 상에 있는 음성 파일이나 음악 파일을 재생하도록 응답 메시지를 작성할 수도 있습니다.

```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "outputSpeech": {
      "type": "SpeechList",
      "values": [
        {
          "type": "PlainText",
          "lang": "ko",
          "value": "노래를 불러볼게요."
        },
        {
          "type": "URL",
          "lang": "" ,
          "value": "https://tts.example.com/song.mp3"
        }
      ]
    },
    "card": {},
    "directives": [],
    "shouldEndSession": true
  }
}
```

각 `response.outputSpeech` 필드를 설명하면 다음과 같습니다.

* `response.outputSpeech.type`: 복문 타입(SpeechList)의 음성 정보입니다.
* `response.outputSpeech.values[0]`: 일반 텍스트 형태의 음성 정보이며, 한국어로 "노래를 불러볼게요"라고 발화하도록 설정했습니다.
* `response.outputSpeech.values[1]`: URI 형태의 음성 정보이며, `value` 필드에 입력된 URI의 파일을 재생하도록 설정했습니다.

HLS 방식의 음원을 제공할 때는 다음과 같이 작성할 수 있습니다. 이때, `response.outputSpeech.values[1].contentType` 필드를 `"application/vnd.apple.mpegurl"`로 지정해야 합니다.

```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "outputSpeech": {
      "type": "SpeechList",
      "values": [
        {
          "type": "PlainText",
          "lang": "ko",
          "value": "노래를 불러볼게요."
        },
        {
          "contentType": "application/vnd.apple.mpegurl",
          "type": "URL",
          "lang": "" ,
          "value": "https://tts.example.com/song.m3u8"
        }
      ]
    },
    "card": {},
    "directives": [],
    "shouldEndSession": true
  }
}
```

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>단문이나 복문 형태의 음성 정보 외에도 스크린 없는 기기와 같이 상세 내용을 GUI로 표현하기 힘든 클라이언트를 위해 복합 형태(SpeechSet)의 음성 정보도 지원하고 있습니다. 레퍼런스 및 제약에 대한 자세한 사항은 custom extension 메시지 포맷의 <a href="/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage">응답 메시지</a>를 참조합니다.</p>
</div>

음성 출력뿐만 아니라 클라이언트 기기의 화면이나 CLOVA 앱 화면에 원하는 데이터를 출력해야 한다면 다음과 같이 `response.card` 필드에 [content template]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/Content_Templates.{{ book.DocMeta.FileExtensionForExternalLink }})에 맞춰 표시할 콘텐츠를 채우면 됩니다.

{% raw %}
```json
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "outputSpeech": {
      "type": "SimpleSpeech",
      "values": {
          "type": "PlainText",
          "lang": "ko",
          "value": "리오넬 메시의 사진이에요."
      }
    },
    "card": {
      "type": "ImageText",
      "imageUrl": {
        "type": "url",
        "value": ""
      },
      "mainText": {
        "type": "string",
        "value": "리오넬 메시"
      },
      "referenceText": {
        "type": "string",
        "value": "검색결과"
      },
      "referenceUrl": {
        "type": "url",
        "value": "https://m.search.example.com/search.naver?where=m&sm=mob_lic&query=%eb%a6%ac%ec%98%a4%eb%84%ac+%eb%a9%94%ec%8b%9c+%ec%86%8c%ec%86%8d%ed%8c%80"
      },
      "subTextList": [
        {
          "type": "string",
          "value": "FC 바르셀로나"
        }
      ],
      "thumbImageType": {
        "type": "string",
        "value": "인물"
      },
      "thumbImageUrl": {
        "type": "url",
        "value": "https://sstatic.example.net/people/3/201607071816066361.jpg"
      }
    },
    "directives": [],
    "shouldEndSession": true
  }
}
```
{% endraw %}
