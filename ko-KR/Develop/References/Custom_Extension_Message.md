<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

# Custom extension 메시지
Custom extension 메시지는 CEK와 custom extension 사이에서 정보를 주고 받을 때 사용하는 메시지입니다. Custom extension 메시지는 [요청 메시지](#CustomExtRequestMessage)와 [응답 메시지](#CustomExtResponseMessage)로 나뉩니다. 요청 메시지는 다시 [요청 타입](#CustomExtRequestType)에 따라 `EventRequest`, `IntentRequest`, `LaunchRequest`, `SessionEndedRequest`과 같이 4 가지 타입으로 구분됩니다.

## 요청 메시지 {#CustomExtRequestMessage}
CEK는 CLOVA가 분석한 사용자의 요구 사항을 custom extension으로 전달할 때 요청 메시지를 전달합니다(HTTP Reqeuset). 여기에서는 요청 메시지의 구조, 각 필드의 설명, 그리고 요청 타입과 각 타입에 따라 달라지는 `request` 필드에 대해 설명합니다.

### Message structure

{% raw %}
```json
{
  "context": {
    "AudioPlayer": {
      "offsetInMilliseconds": {{number}},
      "playerActivity": {{string}},
      "stream": {{AudioStreamInfoObject}},
      "totalInMilliseconds": {{number}},
    },
    "System": {
      "application": {
        "applicationId": {{string}}
      },
      "device": {
        "deviceId": {{string}},
        "display": {
          "contentLayer": {
            "width": {{number}},
            "height": {{number}}
          },
          "dpi": {{number}},
          "orientation": {{string}},
          "size": {{string}}
        }
      },
      "user": {
        "userId": {{string}},
        "accessToken": {{string}}
      }
    }
  },
  "request": {{object}},
  "session": {
    "new": {{boolean}},
    "sessionAttributes": {{object}},
    "sessionId": {{string}},
    "user": {
      "userId": {{string}},
      "accessToken": {{string}}
    }
  },
  "version": {{string}}
}
```
{% endraw %}

### Message fields
| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `context`                                  | object  | 클라이언트의 맥락 정보를 가지고 있는 객체                                | 항상 |
| `context.AudioPlayer`                      | object  | 클라이언트가 현재 재생하고 있거나 마지막으로 재생한 미디어 정보를 가지고 있는 객체 | 조건부 |
| `context.AudioPlayer.offsetInMilliseconds` | number  | 최근 재생 미디어의 마지막 재생 지점(offset). 단위는 밀리초이며, `playerActivity` 값이 `"IDLE"`이면 이 필드 값이 비어 있을 수도 있습니다.                                       | 조건부 |
| `context.AudioPlayer.playerActivity`       | string  | 플레이어의 상태를 나타내는 값이며 다음과 같은 값을 가집니다.<ul><li><code>"IDLE"</code>: 비활성 상태</li><li><code>"PLAYING"</code>: 재생 중인 상태</li><li><code>"PAUSED"</code>: 일시 정지 상태</li><li><code>"STOPPED"</code>: 중지 상태</li></ul> | 항상 |
| `context.AudioPlayer.stream`               | [AudioStreamInfoObject]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#AudioStreamInfoObject) | 재생 중인 미디어의 상세 정보를 보관한 객체. `playerActivity` 값이 `"IDLE"`이면 이 필드 값이 비어 있을 수도 있습니다.    | 조건부 |
| `context.AudioPlayer.totalInMilliseconds`  | number  | 최근 재생 미디어의 전체 길이. 단위는 밀리초이며, `playerActivity` 값이 `"IDLE"`이면 이 필드 값이 비어 있을 수도 있습니다.                                                                  | 조건부 |
| `context.System`                           | object  | 클라이언트 시스템의 맥락 정보를 가지고 있는 객체                          | 항상 |
| `context.System.application`               | object  | 사용자 의도에 의해 실행되어야 하는 extension의 정보를 가지고 있는 객체       | 항상 |
| `context.System.application.applicationId` | string  | Extension의 ID                                                 | 항상 |
| `context.System.device`                    | object  | 클라이언트 기기의 정보를 가지고 있는 객체                               | 항상 |
| `context.System.device.deviceId`           | string  | 클라이언트 기기 ID. 모델명과 기기 시리얼 번호가 조합된 정보와 같이 사용자 기기를 식별할 수 있는 정보가 전달됩니다. | 항상 |
| `context.System.device.display`            | object  | 클라이언트 기기의 디스플레이 정보를 가지고 있는 객체                                                 | 항상 |
| `context.System.device.display.contentLayer`        | object | 디스플레이에서 콘텐츠가 표시되는 영역의 해상도 정보를 가지는 객체. `context.System.device.display.size`의 값이 `"none"`이면 이 필드는 생략됩니다.  | 조건부 |
| `context.System.device.display.contentLayer.width`  | number | 디스플레이에서 콘텐츠가 표시되는 영역의 너비. 단위는 픽셀(px)입니다.             | 항상 |
| `context.System.device.display.contentLayer.height` | number | 디스플레이에서 콘텐츠가 표시되는 영역의 높이. 단위는 픽셀(px)입니다.             | 항상 |
| `context.System.device.display.dpi`         | number | 디스플레이 장치의 DPI. `context.System.device.display.size`의 값이 `"none"`이면 이 필드는 생략됩니다.          | 조건부 |
| `context.System.device.display.orientation` | string | 디스플레이 장치의 방향. `context.System.device.display.size`의 값이 `"none"`이면 이 필드는 생략됩니다.<ul><li><code>"landscape"</code>: 가로 방향</li><li><code>"portrait"</code>: 세로 방향</li></ul>                      | 조건부 |
| `context.System.device.display.size`        | string | 디스플레이 장치의 해상도 크기를 나타내는 값. 크기가 미리 지정된 값 또는 임의의 해상도 크기를 의미하는 값(`"custom"`)이 입력되어 있을 수도 있습니다. 또는 디스플레이 장치가 없음을 의미하는 값(`"none"`)이 입력되어 있을 수도 있습니다. <ul><li><code>"none"</code>: 클라이언트 기기에 디스플레이 장치가 없음</li><li><code>"s100"</code>: 저해상도(160px X 107px)</li><li><code>"m100"</code>: 중간 해상도(427px X 240px)</li><li><code>"l100"</code>: 고해상도(640px X 360px)</li><li><code>"xl100"</code>: 초고해상도(xlarge type, 899px X 506px)</li><li><code>"custom"</code>: 미리 정의된 규격이 아닌 해상도.</li></ul><div class="note"><p><strong>Note!</strong></p><p>클라이언트 기기의 화면 비율과 DPI에 맞는 화질의 미디어 콘텐츠를 제공해야 합니다.</p></div> | 항상 |
| `context.System.user`                      | object  | 클라이언트 기기에 인증된 기본 사용자 정보를 가지고 있는 객체                 | 항상 |
| `context.System.user.userId`               | string  | 기기 기본 사용자의 CLOVA ID                                    | 항상 |
| `context.System.user.accessToken`          | string  | 특정 서비스의 사용자 계정의 access token. 기기 기본 사용자와 연결된 사용자 계정의 access token이 전달됩니다. CEK는 외부 서비스의 인증 서버로부터 획득한 사용자 계정의 access token을 전달합니다. 자세한 설명은 [사용자 계정 연결하기](/Develop/Guides/Link_User_Account.md)를 참조합니다. | 항상 |
| `request`                                 | object  | 분석된 사용자의 발화 정보를 가지고 있는 객체. [요청 타입](#CustomExtRequestType)에 따라 구성되는 필드가 달라집니다. | 항상 |
| `session`                                  | object  | 세션 정보를 가지고 있는 객체. 여기서 세션은 사용자의 요청을 구분하는 논리적 단위입니다.     | 항상 |
| `session.new`                              | boolean | 요청 메시지가 새로운 세션에 대한 것인지 아니면 기존 세션에 대한 것인지 구분합니다. <ul><li>true: 새로운 세션</li><li>false: 기존 세션</li></ul>  | 항상 |
| `session.sessionAttributes`                       | object  | 사용자와의 multi-turn 대화를 위해 필요한 정보를 저장해둔 객체. Custom extension은 [응답 메시지](#CustomExtResponseMessage)의 `response.sessionAttributes` 필드를 이용해 중간 정보를 CEK에 전달하게 되며, 사용자의 추가 요청을 수신할 때 다시 해당 정보를 요청 메시지의 `session.sessionAttributes` 필드로 받게 됩니다. 객체는 키(key)-값(value)의 쌍으로 구성되며, custom extension을 구현할 때 임의로 정의할 수 있습니다. 저장된 값이 없으면 빈 객체가 전달됩니다.   | 항상 |
| `session.sessionId`                        | string  | 세션 ID                                                    | 항상 |
| `session.user`                             | object  | 현재 사용자의 정보를 가지고 있는 객체                             | 항상 |
| `session.user.userId`                      | string  | 현재 사용자의 CLOVA ID. `context.System.user.userId` 값과 다를 수 있습니다. | 항상 |
| `session.user.accessToken`                 | string  | 특정 서비스의 사용자 계정의 access token. 현재 사용자와 연결된 사용자 계정의 access token이 전달됩니다. CEK는 외부 서비스의 인증 서버로부터 획득한 사용자 계정의 access token을 전달합니다. 자세한 설명은 [사용자 계정 연결하기](/Develop/Guides/Link_User_Account.md)를 참조합니다.| 조건부 |
| `version`                                  | string  | 메시지 포맷의 버전 (CEK 버전)                          | 항상 |

### Message example
{% raw %}
```json
// 예제 1: EventRequest 타입
{
  "version": "0.1.0",
  "session": {
    "new": false,
    "sessionAttributes": {},
    "sessionId": "a29cfead-c5ba-474d-8745-6c1a6625f0c5",
    "user": {
      "userId": "V0qe",
      "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
    }
  },
  "context": {
    "System": {
      "application": {
        "applicationId": "com.example.extension.pizzabot"
      },
      "user": {
        "userId": "V0qe",
        "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
      },
      "device": {
        "deviceId": "096e6b27-1717-33e9-b0a7-510a48658a9b",
        "display": {
          "size": "l100",
          "orientation": "landscape",
          "dpi": 96,
          "contentLayer": {
            "width": 640,
            "height": 360
          }
        }
      }
    }
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
  }
}

// 예제 2: IntentRequest 타입
{
  "version": "0.1.0",
  "session": {
    "new": false,
    "sessionAttributes": {},
    "sessionId": "a29cfead-c5ba-474d-8745-6c1a6625f0c5",
    "user": {
      "userId": "V0qe",
      "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
    }
  },
  "context": {
    "System": {
      "application": {
        "applicationId": "com.example.extension.pizzabot"
      },
      "user": {
        "userId": "V0qe",
        "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
      },
      "device": {
        "deviceId": "096e6b27-1717-33e9-b0a7-510a48658a9b",
        "display": {
          "size": "l100",
          "orientation": "landscape",
          "dpi": 96,
          "contentLayer": {
            "width": 640,
            "height": 360
          }
        }
      }
    }
  },
  "request": {
    "type": "IntentRequest",
    "intent": {
      "name": "OrderPizza",
      "slots": {
        "pizzaType": {
          "name": "pizzaType",
          "value": "페퍼로니"
        }
      }
    }
  }
}

// 예제 3: LaunchRequest 타입
{
  "version": "0.1.0",
  "session": {
    "new": true,
    "sessionAttributes": {},
    "sessionId": "a29cfead-c5ba-474d-8745-6c1a6625f0c5",
    "user": {
      "userId": "V0qe",
      "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
    }
  },
  "context": {
    "System": {
      "application": {
        "applicationId": "com.example.extension.pizzabot"
      },
      "user": {
        "userId": "V0qe",
        "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
      },
      "device": {
        "deviceId": "096e6b27-1717-33e9-b0a7-510a48658a9b",
        "display": {
          "size": "l100",
          "orientation": "landscape",
          "dpi": 96,
          "contentLayer": {
            "width": 640,
            "height": 360
          }
        }
      }
    }
  },
  "request": {
    "type": "LaunchRequest"
  }
}

// 예제 4: SessionEndedRequest 타입
{
  "version": "0.1.0",
  "session": {
    "new": false,
    "sessionAttributes": {},
    "sessionId": "a29cfead-c5ba-474d-8745-6c1a6625f0c5",
    "user": {
      "userId": "V0qe",
      "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
    }
  },
  "context": {
    "System": {
      "application": {
        "applicationId": "com.example.extension.pizzabot"
      },
      "user": {
        "userId": "V0qe",
        "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
      },
      "device": {
        "deviceId": "096e6b27-1717-33e9-b0a7-510a48658a9b",
        "display": {
          "size": "l100",
          "orientation": "landscape",
          "dpi": 96,
          "contentLayer": {
            "width": 640,
            "height": 360
          }
        }
      }
    }
  },
  "request": {
    "type": "SessionEndedRequest"
  }
}
```
{% endraw %}

### See also
* [Custom extension 요청 처리하기](/Develop/Guides/Build_Custom_Extension.md#HandleCustomExtensionRequest)
* [AudioStreamInfoObject]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#AudioStreamInfoObject)

## 요청 타입 {#CustomExtRequestType}
요청 메시지는 다음과 같이 4 가지 요청 타입으로 나뉘며, 각 요청 타입마다 요청 메시지의 `request` 객체의 필드 구성이 달라집니다.
* [`EventRequest`](#CustomExtEventRequest)
* [`IntentRequest`](#CustomExtIntentRequest)
* [`LaunchRequest`](#CustomExtLaunchRequest)
* [`SessionEndedRequest`](#CustomExtSessionEndedRequest)

### EventRequest {#CustomExtEventRequest}
{% if book.L10N.TargetCountryCode == "KR" %}
`EventRequest` 타입은 클라이언트의 상태 변화나 그와 관련된 부수적인 요청을 extension에 전달해야 할 때 사용되는 요청 타입입니다. CEK는 `EventRequest` 요청 타입을 사용하여 다음과 같은 작업을 처리합니다.
* 클라이언트의 [오디오 재생 상태를 extension에 보고](/Develop/Guides/Build_Custom_Extension.md#CollectPlaybackStatusAndProgress)
* [오디오 재생 관련 부가 정보를 extension에 요청](/Develop/Guides/Build_Custom_Extension.md#ProvidingMetaDataForDisplay)
* 클라이언트의 [음성(TTS) 재생 상태를 extension에 보고](/Develop/Guides/Monitor_TTS_Playback_Status.md)

Extension 개발자는 오디오 또는 음성 재생 상태 보고 또는 부가 정보 요청에 상응하는 작업을 처리해야 합니다. 현재 `EventRequest` 요청 타입을 사용하여 위와 같은 작업을 처리할 때 다음과 같은 [CIC API]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }})의 [이벤트 메시지]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/CIC_API.{{ book.DocMeta.FileExtensionForExternalLink }}#Event)를 이용합니다.

* [`AudioPlayer.PlayFinished`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayFinished)
* [`AudioPlayer.PlayPaused`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayPaused)
* [`AudioPlayer.PlayResumed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayResumed)
* [`AudioPlayer.PlayStarted`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayStarted)
* [`AudioPlayer.PlayStopped`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#PlayStopped)
* [`AudioPlayer.ProgressReportDelayPassed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#ProgressReportDelayPassed)
* [`AudioPlayer.ProgressReportIntervalPassed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#ProgressReportIntervalPassed)
* [`AudioPlayer.ProgressReportPositionPassed`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#ProgressReportPositionPassed)
* [`AudioPlayer.StreamRequested`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}#StreamRequested)
* [`SpeechSynthesizer.SpeechFinished`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechSynthesizer.{{ book.DocMeta.FileExtensionForExternalLink }}#SpeechFinished)
* [`SpeechSynthesizer.SpeechStarted`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechSynthesizer.{{ book.DocMeta.FileExtensionForExternalLink }}#SpeechStarted)
* [`SpeechSynthesizer.SpeechStopped`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechSynthesizer.{{ book.DocMeta.FileExtensionForExternalLink }}#SpeechStopped)
* [`TemplateRuntime.RequestPlayerInfo`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/TemplateRuntime.{{ book.DocMeta.FileExtensionForExternalLink }}#RequestPlayerInfo)
{% elif book.L10N.TargetCountryCode == "JP" %}
`EventRequest` 타입은 클라이언트의 상태 변화나 그와 관련된 부수적인 요청을 extension에 전달해야 할 때 사용되는 요청 타입입니다. CEK는 `EventRequest` 요청 타입을 사용하여 다음과 같은 작업을 처리합니다.
* 사용자가 특정 skill을 활성 또는 비활성화한 결과를 보고
* 클라이언트의 [오디오 재생 상태를 extension에 보고](/Develop/Guides/Build_Custom_Extension.md#CollectPlaybackStatusAndProgress)
* [오디오 재생 관련 부가 정보를 extension에 요청](/Develop/Guides/Build_Custom_Extension.md#ProvidingMetaDataForDisplay)
* 클라이언트의 [음성(TTS) 재생 상태를 extension에 보고](/Develop/Guides/Monitor_TTS_Playback_Status.md)

Extension 개발자는 skill의 활성/비활성화, 오디오 또는 음성 재생 상태 보고 또는 부가 정보 요청에 상응하는 작업을 처리해야 합니다.

`EventRequest` 요청 타입을 사용하여 오디오 재생 상태 보고나 부가 정보 요청 정보를 extension으로 전달할 때 다음과 같은 [CIC API](#CICAPIforAudioPlayback)를 이용합니다.

* [`AudioPlayer.PlayFinished`](#PlayFinished)
* [`AudioPlayer.PlayPaused`](#PlayPaused)
* [`AudioPlayer.PlayResumed`](#PlayResumed)
* [`AudioPlayer.PlayStarted`](#PlayStarted)
* [`AudioPlayer.PlayStopped`](#PlayStopped)
* [`AudioPlayer.ProgressReportDelayPassed`](#ProgressReportDelayPassed)
* [`AudioPlayer.ProgressReportIntervalPassed`](#ProgressReportIntervalPassed)
* [`AudioPlayer.ProgressReportPositionPassed`](#ProgressReportPositionPassed)
* [`AudioPlayer.StreamRequested`](#StreamRequested)
* [`SpeechSynthesizer.SpeechFinished`](#SpeechFinished)
* [`SpeechSynthesizer.SpeechStarted`](#SpeechStarted)
* [`SpeechSynthesizer.SpeechStopped`](#SpeechStopped)
* [`TemplateRuntime.RequestPlayerInfo`](#RequestPlayerInfo)
{% endif %}

`EventRequest` 타입 메시지의 `request` 객체 필드 구성은 다음과 같습니다.

{% raw %}
```json
{
  "type": "EventRequest",
  "requestId": {{string}},
  "timestamp": {{string}},
  "event": {
    "namespace": {{string}},
    "name": {{string}},
    "payload": {{object}}
  }
}
```
{% endraw %}

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `event`           | object  | 클라이언트가 CLOVA로 전달한 정보가 저장된 객체                                       | 항상   |
| `event.name`      | string  | {{ "클라이언트가 CLOVA로 전달한 이벤트 메시지의 이름" if book.L10N.TargetCountryCode == "KR" else "클라이언트가 CLOVA로 전달한 이벤트 메시지의 이름이나 skill 활성 또는 비활성 동작을 구분하는 이름. Skill 활성 또는 비활성 동작을 구분하는 이름은 `SkillEnabled` 또는 `SkillDisabled`를 가집니다. Skill 활성 또는 비활성 동작을 나타내는 요청을 받게 되면 [요청 메시지](#CustomExtRequestMessage)의 `context.System.application.applicationId` 필드와 `context.System.user.userId` 필드를 활용하여 사용자 정보 수집하거나 사용자 정보를 폐기하도록 구현할 수 있습니다." }} | 항상   |
| `event.namespace` | string  | {{ "클라이언트가 CLOVA로 전달한 이벤트 메시지의 네임스페이스" if book.L10N.TargetCountryCode == "KR" else "클라이언트가 CLOVA로 전달한 이벤트 메시지의 네임스페이스나 skill 활성/비활성 동작을 구분하는 네임스페이스. Skill 활성/비활성 동작을 구분하는 네임스페이스는 `ClovaSkill`로 고정됩니다." }}   | 항상  |
| `event.payload`   | object  | {{ "클라이언트가 CLOVA로 전달한 이벤트 메시지의 `payload`나 `payload`의 일부 정보. 일부 이벤트 메시지의 `EventRequest` 요청 타입은 `payload`가 빈 객체일 수 있습니다." if book.L10N.TargetCountryCode == "KR" else "클라이언트가 CLOVA로 전달한 이벤트 메시지의 `payload`나 `payload`의 일부 정보. 일부 이벤트 메시지나 skill 활성/비활성 동작을 구분하기 위한 `EventRequest` 요청 타입은 `payload`가 빈 객체일 수 있습니다." }}  | 항상  |
| `requestId`       | string  | 클라이언트가 CLOVA로 정보를 전달할 때 생성된 대화 ID(`event.header.dialogRequestId`)    | 항상   |
| `timestamp`       | string  | 클라이언트가 CLOVA로 정보를 전달한 시간(`"YYYY-MM-DDThh:mm:ssZ"` <a href="https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations" target="_blank">ISO 8601</a> 형식)<div class="tip"><p><strong>Tip!</strong></p><p>CEK는 <code>EventRequest</code> 타입 요청 간의 순서를 보장하지 않기 때문에 이 필드 값을 활용하여 클라이언트의 요청의 순서를 파악할 수 있습니다.</p></div>                    |   |
| `type`            | string  | 요청 메시지의 타입. `"EventRequest"` 값으로 고정됩니다.         | 항상 |

다음은 `EventRequest` 타입 메시지 `request` 객체 필드의 예제입니다.

{% if book.L10N.TargetCountryCode == "KR" %}
```json
// 예제 1. 음악에 대한 메타 정보를 요청했을 때
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

// 예제 2. 음악 재생을 중지했을 때
"request": {
  "type": "EventRequest",
  "requestId": "e5464288-50ff-4e99-928d-4a301e083d41",
  "timestamp": "2017-09-05T05:41:21Z",
  "event": {
    "namespace": "AudioPlayer",
    "name": "PlayStopped",
    "payload": {}
  }
}
```
{% elif book.L10N.TargetCountryCode == "JP" %}
```json
// 예제 1. 사용자가 skill을 활성화했을 때
"request": {
  "type": "EventRequest",
  "requestId": "f09874hiudf-sdf-4wku-flksdjfo4hjsdf",
  "timestamp": "2018-06-11T09:19:23Z",
  "event" : {
    "namespace":"ClovaSkill",
    "name":"SkillEnabled",
    "payload": null
  }
}

// 예제 2. 사용자가 skill을 비활성화했을 때
"request": {
  "type": "EventRequest",
  "requestId": "f09874hiudf-sdf-4wku-flksdjfo4hjsdf",
  "timestamp": "2018-06-19T11:37:21Z",
  "event" : {
    "namespace":"ClovaSkill",
    "name":"SkillDisabled",
    "payload": null
  }
}

// 예제 3. 음악에 대한 메타 정보를 요청했을 때
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

// 예제 4. 음악 재생을 중지했을 때
"request": {
  "type": "EventRequest",
  "requestId": "e5464288-50ff-4e99-928d-4a301e083d41",
  "timestamp": "2017-09-05T05:41:21Z",
  "event": {
    "namespace": "AudioPlayer",
    "name": "PlayStopped",
    "payload": {}
  }
}
```
{% endif %}

### IntentRequest {#CustomExtIntentRequest}
`IntentRequest` 타입은 분석한 사용자의 요청을 전달하여 그 내용을 수행하도록 하는 요청 타입입니다. Extension 개발자는 서비스를 만들 때 사용자의 요청을 어떻게 받을지 [interaction 모델을 정의](/Design/Design_Custom_Extension.md#DefineInteractionModel)해야 하며, Interaction 모델은 [CLOVA developer console](/DevConsole/ClovaDevConsole_Overview.md)을 통해 등록할 수 있습니다. 이때, 구별되는 사용자의 요청을 Intent라는 정보 형태로 정의합니다. 분석된 사용자의 발화 정보는 Intent로 변환되며, `intent` 필드를 통해 extension에 전달됩니다.

`IntentRequest` 타입 메시지의 `request` 객체 필드 구성은 다음과 같습니다.

{% raw %}
```json
{
  "type": "IntentRequest",
  "intent": {
    "name": {{string}},
    "slots": {{object}}
  }
}
```
{% endraw %}

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `intent`        | object  | 사용자의 요청을 분석한 정보가 저장된 객체 [intent](/Design/Design_Custom_Extension.md#Intent)                          | 항상 |
| `intent.name`   | string  | Intent 이름. Interaction 모델에 정의한 [intent](/Design/Design_Custom_Extension.md#Intent)를 이 필드로 식별할 수 있다.  | 항상 |
| `intent.slots`  | object  | Extension이 intent를 처리할 때 요구되는 정보(slot)가 저장된 객체. 이 필드는 `intent.name` 필드에 입력된 [intent](/Design/Design_Custom_Extension.md#Intent)에 따라 구성이 달라질 수 있다. | 항상 |
| `type`          | string  | 요청 메시지의 타입. `"IntentRequest"` 값으로 고정됩니다.                                                                     | 항상 |

다음은 `IntentRequest` 타입 메시지 `request` 객체 필드의 예제입니다.

```json
"request": {
  "type": "IntentRequest",
  "intent": {
    "name": "OrderPizza",
    "slots": {
      "pizzaType": {
        "name": "pizzaType",
        "value": "페퍼로니"
      }
    }
  }
}
```

### LaunchRequest {#CustomExtLaunchRequest}
`LaunchRequest` 타입은 사용자의 특정 extension 사용 시작을 알리는 요청 타입입니다. 예를 들면, 사용자가 "주사위 놀이 시작해줘"라고 말한 것과 같이 특정 skill을 사용하겠다고 선언한 상황입니다. 사용자가 skill을 그만 사용하겠다고 선언할 때까지 해당 extension의 [`IntentRequest`](#CustomExtIntentRequest) 타입의 메시지를 받게 됩니다.

`LaunchRequest` 타입 메시지의 `request` 객체 필드 구성은 다음과 같습니다.

{% raw %}
```json
{
  "type": "LaunchRequest"
}
```
{% endraw %}

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `type`          | string  | 요청 메시지의 타입. `"LaunchRequest"` 값으로 고정됩니다. | 항상 |

### SessionEndedRequest {#CustomExtSessionEndedRequest}
`SessionEndedRequest` 타입은 사용자의 특정 skill 사용이 종료되었음을 알리는 요청입니다. 다음과 같은 상황에서 이 메시지를 받게 됩니다.
* 사용자가 skill 종료를 요청했을 때
* 특정 시간 동안 사용자의 입력이 없을 때(Timeout)
* 오류가 발생했을 때

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p><a href="#CustomExtResponseMessage">응답 메시지</a>의 <code>shouldEndSession</code> 필드를 사용하여 extension 쪽에서 먼저 종료를 선언했다면 이 메시지를 수신하지 않습니다.</p>
</div>

`SessionEndedRequest` 타입 메시지의 `request` 객체 필드 구성은 다음과 같습니다.

{% raw %}
```json
{
  "type": "SessionEndedRequest"
}
```
{% endraw %}

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `type`          | string  | 요청 메시지의 타입. `"SessionEndedRequest"` 값으로 고정됩니다. | 항상 |

## 응답 메시지 {#CustomExtResponseMessage}
Extension은 요청 메시지를 처리한 후 응답 메시지를 전달해야 합니다(HTTP Response). 여기에서는 응답 메시지의 구조와 각 필드에 대해 설명합니다.

### Message structure
{% raw %}
```json
{
  "response": {
    "card": {{object}},
    "directives": [
      {
        "header": {
          "messageId": {{string}},
          "name": {{string}},
          "namespace": {{string}}
        },
        "payload": {{object}}
      }
    ],
    "outputSpeech": {
      "type": {{string}},
      "values": {{SpeechInfoObject|SpeechInfoObject array}},
      "brief": {{SpeechInfoObject}},
      "verbose": {
        "type": {{string}},
        "values": {{SpeechInfoObject|SpeechInfoObject array}},
      }
    },
    "reprompt": {
      "outputSpeech": {
        "type": {{string}},
        "values": {{SpeechInfoObject|SpeechInfoObject array}},
        "brief": {{SpeechInfoObject}},
        "verbose": {
          "type": {{string}},
          "values": {{SpeechInfoObject|SpeechInfoObject array}},
        }
      }
    },
    "shouldEndSession": {{boolean}},
  },
  "sessionAttributes": {{object}},
  "version": {{string}}
}
```
{% endraw %}

### Message fields
| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `response`                               | object       | Extension의 응답 정보가 담긴 객체                            | 필수 |
| `response.card`                          | object       | [Content template]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/Content_Templates.{{ book.DocMeta.FileExtensionForExternalLink }}) 형태의 데이터이며, 클라이언트 화면에 표시할 콘텐트를 이 필드를 통해 전달할 수 있습니다. 이 필드에 데이터가 있으면 CIC는 클라이언트에 [Clova.RenderTemplate]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/Clova.{{ book.DocMeta.FileExtensionForExternalLink }}#RenderTemplate) 지시 메시지를 전달하게 되며, 빈 객체이면 CIC는 클라이언트에 [Clova.RenderText]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/Clova.{{ book.DocMeta.FileExtensionForExternalLink }}#RenderText) 지시 메시지를 전달하여 `response.outputSpeech.values` 필드의 값을 표시하게 합니다.        | 필수 |
| `response.directives[]`                  | object array | Extension이 CEK로 전달하는 지시 메시지입니다. `response.directives` 필드는 주로 오디오 콘텐츠 제공을 위해 사용되며, 다음과 같은 {%- if book.L10N.TargetCountryCode == "KR" -%}[CIC API](https://developers.naver.com/docs/clova/client/Develop/References/CIC_API.md){%- elif book.L10N.TargetCountryCode == "JP" -%}[CIC API](#CICAPIforAudioPlayback){%- endif -%} 지시 메시지를 지원합니다.<ul><li><code>AudioPlayer.Play</code></li><li><code>AudioPlayer.StreamDeliver</code></li><li><code>PlaybackController.Pause</code></li><li><code>PlaybackController.Resume</code></li><li><code>PlaybackController.Stop</code></li><li><code>TemplateRuntime.RenderPlayerInfo</code></li></ul><div class="note"><p><strong>Note!</strong></p><p>CIC API 지시 메시지</p>를 작성할 때 "포함여부"가 <strong>"항상"</strong>인 필드는 필수이며, 반드시 작성해야 합니다.</p></div> | 필수 |
| `response.directives[].header`           | object       | 지시 메시지의 헤더                                          | 필수 |
| `response.directives[].header.messageId` | string       | 메시지 ID(UUID). 개별 메시지를 구분하기 위해 사용하는 식별자입니다.   | 필수 |
| `response.directives[].header.name`      | string       | 지시 메시지의 API 이름                                      | 필수 |
| `response.directives[].header.namespace` | string       | 지시 메시지의 API 네임스페이스                                | 필수 |
| `response.directives[].payload`          | object       | 지시 메시지와 관련된 정보를 담고 있는 객체. 지시 메시지에 따라 payload 객체의 구성과 필드 값을 달리 작성할 수 있습니다.         | 필수 |
| `response.outputSpeech`                  | object       | 음성으로 합성할 정보를 담고 있는 객체. 합성된 음성 정보는 CIC를 거쳐 클라이언트로 전달됩니다.              | 필수 |
| `response.outputSpeech.brief`            | [SpeechInfoObject](#CustomExtSpeechInfoObject) | 출력할 요약 음성 정보                    | 선택 |
| `response.outputSpeech.type`             | string       | 출력할 음성 정보의 타입. <ul><li><code>"SimpleSpeech"</code>: 단문 형태의 음성 정보입니다. 가장 기본적인 타입이며, 이 값을 지정하면 <code>response.outputSpeech.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체를 가져야 합니다.</li><li><code>"SpeechList"</code>: 복문 형태의 음성 정보입니다. 여러 문장을 출력할 때 사용되며, 이 값을 지정하면 <code>response.outputSpeech.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체 배열을 가져야 합니다.</li><li><code>"SpeechSet"</code>: 복합 형태의 음성 정보입니다. 스크린이 없는 클라이언트 기기에 요약 음성 정보와 상세 음성 정보를 전달할 때 사용합니다. 이 값을 지정하면 <code>response.outputSpeech.values</code> 필드 대신 <code>response.outputSpeech.brief</code>와 <code>response.outputSpeech.verbose</code> 필드를 가져야 합니다.</li></ul> | 필수 |
| `response.outputSpeech.values[]`           | [SpeechInfoObject](#CustomExtSpeechInfoObject) or [SpeechInfoObject](#CustomExtSpeechInfoObject) array | 클라이언트 기기에서 출력할 음성 정보를 담고 있는 객체 또는 객체 배열 | 선택 |
| `response.outputSpeech.verbose`          | object       | 스크린이 없는 클라이언트 기기에 전달할 때 사용되며, 상세 음성 정보를 가집니다. | 선택 |
| `response.outputSpeech.verbose.type`     | string       | 출력할 음성 정보의 타입. 단문과 복문 형태의 음성 정보만 입력할 수 있습니다. <ul><li><code>"SimpleSpeech"</code>: 단문 형태의 음성 정보입니다. 가장 기본적인 음성 정보를 전달할 때 사용되며, 이 값을 지정하면 <code>response.outputSpeech.verbose.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체를 가져야 합니다.</li><li><code>"SpeechList"</code>: 복문 형태의 음성 정보입니다. 여러 문장을 출력할 때 사용되며, 이 값을 지정하면 <code>response.outputSpeech.verbose.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체 배열을 가져야 합니다.</li></ul> | 필수 |
| `response.outputSpeech.verbose.values[]`           | [SpeechInfoObject](#CustomExtSpeechInfoObject) or [SpeechInfoObject](#CustomExtSpeechInfoObject) array | 클라이언트 기기에서 출력할 상세 음성 정보를 담고 있는 객체 또는 객체 배열 | 필수 |
| `response.reprompt`                               | obejct       | 사용자 추가 발화를 독려하는 음성 정보를 담고 있는 객체. `response.reprompt` 필드를 사용하면 사용자에게 multi-turn 대화를 계속 이어갈지 의사를 묻거나 또는 필수적인 정보를 추가로 입력하도록 독려할 수 있습니다. 일반적으로 Multi-turn 대화를 할 때 사용자가 추가 발화를 하지 않으면 입력 대기 시간이 초과되어 multi-turn 대화가 자동 종료됩니다. 하지만, `response.reprompt` 필드를 사용하면 CLOVA는 클라이언트가 입력 대기 시간이 초과된 이후에 `response.reprompt` 필드에 작성한 음성을 출력하고 한 번 더 사용자의 추가 발화를 입력 받도록 [`SpeechSynthesizer.Speak`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechSynthesizer.{{ book.DocMeta.FileExtensionForExternalLink }}#Speak) 지시 메시지와 [`SpeechRecognizer.ExpectSpeech`]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/SpeechRecognizer.{{ book.DocMeta.FileExtensionForExternalLink }}#ExpectSpeech) 지시 메시지를 클라이언트에 전달합니다.<div class="tip"><p><strong>Tip!</strong></p><p><code>response.reprompt</code> 필드는 <code>response.shouldEndSession</code> 필드 값을 <code>false</code>로 입력했을 때 유효합니다. 주로 단문 형태의 음성 정보(<code>"SimpleSpeech"</code>)를 보낼 것을 권장하며, <code>response.reprompt</code> 필드를 사용하면 입력 대기 시간을 최대 1 회 연장할 수 있습니다.</p></div> | 선택 |
| `response.reprompt.outputSpeech`                  | object       | 음성으로 합성할 정보를 담고 있는 객체. 합성된 음성 정보는 CIC를 거쳐 클라이언트로 전달됩니다.              | 필수 |
| `response.reprompt.outputSpeech.brief`            | [SpeechInfoObject](#CustomExtSpeechInfoObject) | 출력할 요약 음성 정보                    | 선택 |
| `response.reprompt.outputSpeech.type`             | string       | 출력할 음성 정보의 타입. <ul><li>"SimpleSpeech": 단문 형태의 음성 정보입니다. 가장 기본적인 타입이며, 이 값을 지정하면 <code>response.outputSpeech.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체를 가져야 합니다.</li><li><code>"SpeechList"</code>: 복문 형태의 음성 정보입니다. 여러 문장을 출력할 때 사용되며, 이 값을 지정하면 <code>response.outputSpeech.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체 배열을 가져야 합니다.</li><li><code>"SpeechSet"</code>: 복합 형태의 음성 정보입니다. 스크린이 없는 클라이언트 기기에 요약 음성 정보와 상세 음성 정보를 전달할 때 사용합니다. 이 값을 지정하면 <code>response.outputSpeech.values</code> 필드 대신 <code>response.outputSpeech.brief</code>와 <code>response.outputSpeech.verbose</code> 필드를 가져야 합니다.</li></ul> | 필수 |
| `response.reprompt.outputSpeech.values[]`           | [SpeechInfoObject](#CustomExtSpeechInfoObject) or [SpeechInfoObject](#CustomExtSpeechInfoObject) array | 클라이언트 기기에서 출력할 음성 정보를 담고 있는 객체 또는 객체 배열 | 선택 |
| `response.reprompt.outputSpeech.verbose`          | object       | 스크린이 없는 클라이언트 기기에 전달할 때 사용되며, 상세 음성 정보를 가집니다. | 선택 |
| `response.reprompt.outputSpeech.verbose.type`     | string       | 출력할 음성 정보의 타입. 단문과 복문 형태의 음성 정보만 입력할 수 있습니다. <ul><li><code>"SimpleSpeech"</code>: 단문 형태의 음성 정보입니다. 가장 기본적인 음성 정보를 전달할 때 사용되며, 이 값을 지정하면 <code>response.outputSpeech.verbose.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체를 가져야 합니다.</li><li><code>"SpeechList"</code>: 복문 형태의 음성 정보입니다. 여러 문장을 출력할 때 사용되며, 이 값을 지정하면 <code>response.outputSpeech.verbose.values</code> 필드가 <a href="#CustomExtSpeechInfoObject"><code>SpeechInfoObject</code></a> 객체 배열을 가져야 합니다.</li></ul> | 필수 |
| `response.reprompt.outputSpeech.verbose.values[]`           | [SpeechInfoObject](#CustomExtSpeechInfoObject) or [SpeechInfoObject](#CustomExtSpeechInfoObject) array | 클라이언트 기기에서 출력할 상세 음성 정보를 담고 있는 객체 또는 객체 배열 | 필수 |
| `response.shouldEndSession`              | boolean      | 세션 종료 플래그. 클라이언트에 특정 extension 사용이 종료됨을 알리는 필드입니다. [`SessionEndedRequest`](#CustomExtSessionEndedRequest) 타입의 요청 메시지를 받기 전에 extension이 먼저 사용 종료를 알릴 때 사용합니다.<ul><li>true: 사용 종료</li><li>false: 계속 사용. 사용자와 multi-turn 대화를 시도하게 됩니다.</li></ul> | 필수 |
| `sessionAttributes`                      | object       | 사용자와의 multi-turn 대화를 위해 필요한 정보를 저장할 때 사용하는 객체. Custom extension은 `sessionAttributes` 필드를 이용해 중간 정보를 CEK에 전달하게 되며, 사용자의 추가 요청을 수신할 때 다시 해당 정보를 [요청 메시지](#CustomExtRequestMessage)의 `session.sessionAttributes` 필드로 받게 됩니다. `sessionAttributes` 객체는 키(key)-값(value)의 쌍으로 구성해야 하며, custom extension을 구현할 때 임의로 정의할 수 있습니다. 저장할 값이 없으면 빈 객체를 입력하면 됩니다. | 필수 |
| `version`                                | string       | 메시지 포맷의 버전 (CEK 버전)                        | 필수 |

<div class="note">
  <p><strong>Note!</strong></p>
  <p><code>response.directives</code> 필드를 통해 extension 임의의 지시 메시지를 전달할 때 사용하려면 사전 협의가 필요합니다. 제휴 담당자와 협의하기 바랍니다.</p>
</div>

### SpeechInfoObject {#CustomExtSpeechInfoObject}
SpeechInfoObject 객체는 응답 메시지의 `response.outputSpeech`에서 재사용되는 객체이며, 사용자에게 출력하려는 음성 정보의 가장 작은 단위인 단문 수준의 발화 정보입니다. 이 객체는 다음과 같은 필드를 가집니다.

| 필드 이름        | 자료형         | 설명                                                                | 필수 여부 |
|----------------|--------------|--------------------------------------------------------------------|:-----:|
| `contentType`    | string       | HLS 방식의 음원을 제공할 때 `"application/vnd.apple.mpegurl"`을 입력합니다.  | 선택   |
| `lang`           | string       | 음성 합성을 할 때 사용할 언어의 코드. 현재 다음과 같은 값을 가집니다.<ul><li><code>"en"</code>: 영어</li><li><code>"ja"</code>: 일본어</li><li><code>"ko"</code>: 한국어</li><li><code>""</code>: <code>type</code> 필드의 값이 <code>"URL"</code>이면 이 필드는 빈 문자열(empty string)을 가집니다.</li></ul>         | 필수 |
| `token`          | string       | 제공할 음성의 token. 이 필드에 값을 입력하면 클라이언트에서 해당 음성이 재생된 결과나 재생 상태를 보고 받을 수 있습니다. 음성 재생 상태에 대한 경과 보고는 [`EventRequest` 요청 타입](/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest)의 메시지를 통해 전달받게 됩니다. UUID 포맷(버전 4)으로 생성해야 합니다.<div class="note"><p><strong>Note!</strong></p><p>이 필드의 최대 길이는 2048 바이트입니다.</p></div> | 선택  |
| `type`           | string       | 재공할 음성의 타입. 이 필드의 값에 따라 `value` 필드 값의 형태가 달라집니다. 현재 다음과 같은 값을 가집니다.<ul><li><code>"PlainText"</code>: 일반 텍스트</li><li><code>"URL"</code>: 음성 및 음악을 재생할 수 있는 파일의 URI</li></ul>            | 필수 |
| `value`          | string       | 음성 합성할 내용 또는 음성 파일의 URI.<code>type</code> 필드의 값에 따라 다음과 같은 제약 사항이 있습니다.<ul><li><code>"PlainText"</code>일 때: TTS로 음성 합성할 텍스트를 입력합니다. 한 <strong>문장당 최대 200 자</strong> 그리고 이 필드에 입력되는 텍스트가 <strong>총 1000 자</strong>를 넘지 않도록 작성해야 합니다.</li><li><code>"URL"</code>일 때: 이 필드의 최대 길이는 <strong>2048 바이트</strong>입니다.</li></ul><div class="tip"><p><strong>Tip!</strong></p><p>응답에 대한 권고 사항은 <a href="/Design/Design_Custom_Extension.md#DecideSoundOutputType">응답 유형 결정</a>을 참조하고 CLOVA가 지원하는 음성 파일 형식에 대한 내용은 <a href="/Design/Supported_Audio_Format.md">플랫폼 지원 오디오 포맷</a>을 참조합니다.</p></div>    | 필수 |

### Message example
{% raw %}
```json
// 예제 1: 단문 형태(SimpleSpeech) 음성 정보 반환 - 일반 텍스트
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "outputSpeech": {
      "type": "SimpleSpeech",
      "values": {
          "type": "PlainText",
          "lang": "en",
          "value": "Hi, nice to meet you"
      }
    },
    "card": {},
    "directives": [],
    "shouldEndSession": false
  }
}

// 예제 2: 복문 형태(SpeechList) 음성 정보 반환 - 일반 텍스트, "URL" 타입 사용
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

// 예제 3: 복문 형태(SpeechList) 음성 정보 반환 - 일반 텍스트, URL 타입 사용(HLS 음원 사용)
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

// 예제 4: 복합 형태(SpeechSet) 음성 정보 반환 - 요약, 상세 음성 정보
{
  "version": "0.1.0",
  "sessionAttributes": {},
  "response": {
    "outputSpeech": {
      "type": "SpeechSet",
      "brief": {
        "type": "PlainText",
        "lang": "ko",
        "value": "날씨 뉴스 입니다."
      },
      "verbose": {
        "type": "SpeechList",
        "values": [
          {
              "type": "PlainText",
              "lang": "ko",
              "value": "주말까지 전국 장맛비…폭염 누그러져."
          },
          {
              "type": "PlainText",
              "lang": "ko",
              "value": "내일 전국 장맛비…곳곳 국지성 호우 주의."
          }
          ...
        ]
      }
    },
    "card": {},
    "directives": [],
    "shouldEndSession": true
  }
}

// 예제 5: multi-turn 대화에서 대화 중간 정보 저장 - sessionAttributes 사용
{
  "version": "0.1.0",
  "sessionAttributes": {
    "RequestedIntent": "OrderPizza",
    "pizzaType": "페퍼로니 피자"
  },
  "response": {
    "outputSpeech": {
      "type": "SimpleSpeech",
      "values": {
          "type": "PlainText",
          "lang": "ko",
          "value": "몇 판 주문할까요?"
      }
    },
    "card": {},
    "directives": [],
    "shouldEndSession": false
  }
}

// 예제 6: multi-turn 대화에서 사용자 추가 발화 독려 - reprompt 사용
{
  "version": "0.1.0",
  "sessionAttributes": {
    "RequestedIntent": "OrderPizza",
    "pizzaType": "페퍼로니 피자"
  },
  "response": {
    "outputSpeech": {
      "type": "SimpleSpeech",
      "values": {
          "type": "PlainText",
          "lang": "ko",
          "value": "몇 판 주문할까요?"
      }
    },
    "card": {},
    "reprompt" : {
      "outputSpeech" : {
        "type" : "SimpleSpeech",
        "values" : {
          "type" : "PlainText",
          "lang" : "ko",
          "value" : "말씀이 없으시면, 주문을 취소할까요?"
        }
      }
    },
    "shouldEndSession": false
  }
}

// 예제 7: 클라이언트에 오디오 콘텐츠 재생 지시하는 응답(response.directives[] 필드 사용)
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
            },
          },
          "playBehavior": "REPLACE_ALL"
        }
      }
    ],
    "outputSpeech": {},
    "shouldEndSession": true
  }
}

// 예제 8: 음성 token 입력 - 재생 경과 확인용
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
          "value": "Hi, nice to meet you"
      }
    },
    "card": {},
    "directives": [],
    "shouldEndSession": false
  }
}
```
{% endraw %}

### See also
* [Custom extension 응답 반환하기](/Develop/Guides/Build_Custom_Extension.md#ReturnCustomExtensionResponse)
* [Content template]({{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/Content_Templates.{{ book.DocMeta.FileExtensionForExternalLink }})

{% if book.L10N.TargetCountryCode == "JP" %}

## 오디오 콘텐츠 재생 관련 CIC API {#CICAPIforAudioPlayback}

<!-- Start of the shared content: CICAPIforAudioPlayback -->

CIC API는 사용자의 클라이언트 기기가 CLOVA와 통신할 때 주고 받는 메시지 규격입니다. 여기서 설명하는 CIC API는 custom extension의 [오디오 콘텐츠 제공](/Develop/Guides/Provide_Audio_Content.md)과 관련하여 CEK에서 지원하는 CIC API입니다. CEK는 클라이언트가 CLOVA에 전달한 이벤트 메시지를 [`EventRequest`](#CustomExtEventRequest) 타입 메시지의 `event` 필드에 채워 보냅니다. 또한, Custom extension은 사용자에게 오디오 콘텐츠를 제공하기 위해 오디오 콘텐츠 재생 제어와 관련된 지시 메시지를 [`응답 메시지`](#CustomExtResponseMessage)의 `response.directives[]` 필드에 채워 보내야 합니다.

따라서, custom extension이 오디오 콘텐츠를 제공한다면 다음과 같은 CIC API를 알아야 합니다.

| 네임스페이스   | 메시지 이름         | 메시지 타입  | 메시지 설명                                   |
|-------------|------------------|-----------|---------------------------------------------|
| AudioPlayer | [`Play`](#Play)                       | Directive | 클라이언트에 특정 오디오 스트림을 재생하거나 재생 대기열에 추가하도록 지시합니다.                         |
| AudioPlayer | [`PlayFinished`](#PlayFinished)       | Event     | 클라이언트가 오디오 스트림 재생을 완료할 때 재생 완료된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.     |
| AudioPlayer | [`PlayPaused`](#PlayPaused)           | Event     | 클라이언트가 오디오 스트림 재생을 일시 정지할 때 일시 정지된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다. |
| AudioPlayer | [`PlayResumed`](#PlayResumed)         | Event     | 클라이언트가 오디오 스트림 재생을 재개할 때 재개된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.         |
| AudioPlayer | [`PlayStarted`](#PlayStarted)         | Event     | 클라이언트가 오디오 스트림 재생을 시작할 때 재생이 시작된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.    |
| AudioPlayer | [`PlayStopped`](#PlayStopped)         | Event     | 클라이언트가 오디오 스트림 재생을 중지할 때 재생이 중지된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.    |
| AudioPlayer | [`ProgressReportDelayPassed`](#ProgressReportPositionPassed) | Event | 오디오 스트림 재생이 시작된 후 지정된 지연 시간만큼 시간이 지났을 때 현재 재생 상태를 CIC로 보고하기 위해 사용됩니다. |
| AudioPlayer | [`ProgressReportIntervalPassed`](#ProgressReportPositionPassed)| Event | 오디오 스트림 재생이 시작된 후 지정된 간격마다 현재 재생 상태를 CIC로 보고하기 위해 사용됩니다. |
| AudioPlayer | [`ProgressReportPositionPassed`](#ProgressReportPositionPassed) | Event | 오디오 스트림 재생이 시작된 후 지정된 보고 시점에 현재 재생 상태를 CIC로 보고하기 위해 사용됩니다. |
| AudioPlayer | [`StreamDeliver`](#StreamDeliver)     | Directive | [`AudioPlayer.StreamRequested`](#StreamRequested) 이벤트 메시지의 응답이며, 실제 음악 재생이 가능한 오디오 스트림 정보를 수신해야 할 때 사용합니다. |
| AudioPlayer | [`StreamRequested`](#StreamRequested) | Event     | 오디오 스트림 재생을 위해 CIC로 스트리밍 URI와 같은 추가 정보를 요청하는 이벤트 메시지입니다.               |
| PlaybackController | [`Pause`](#Pause)              | Directive | 클라이언트에 재생 중인 오디오 스트림을 일시 정지하도록 지시합니다.        |
| PlaybackController | [`Resume`](#Resume)            | Directive | 클라이언트에 오디오 스트림 재생을 재개하도록 지시합니다.                |
| PlaybackController | [`Stop`](#Stop)                | Directive | 클라이언트에 오디오 스트림 재생을 중지하도록 지시합니다.                |
| SpeechSynthesizer | [`SpeechFinished`](#SpeechFinished) | Event | 클라이언트가 TTS 재생을 완료했음을 보고하기 위해 사용됩니다.  |
| SpeechSynthesizer | [`SpeechStarted`](#SpeechStarted)   | Event | 클라이언트가 TTS 재생을 시작했음을 보고하기 위해 사용됩니다.  |
| SpeechSynthesizer | [`SpeechStopped`](#SpeechStopped)   | Event | 클라이언트가 TTS 재생을 중지했음을 보고하기 위해 사용됩니다.  |
| TemplateRuntime | [`RenderPlayerInfo`](#RenderPlayerInfo)        | Directive | CIC가 클라이언트에 미디어 플레이어에 표시할 재생 목록, 앨범 이미지, 가사와 같은 재생 메타 정보를 전달하고 이를 표시하도록 지시합니다. |
| TemplateRuntime | [`RequestPlayerInfo`](#RequestPlayerInfo)      | Event     | 클라이언트가 미디어 플레이어에 표시할 재생 목록, 앨범 이미지, 가사와 같은 재생 메타 정보를 CIC에 요청합니다. |

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.Play -->

### AudioPlayer.Play directive {#Play}
클라이언트에 특정 오디오 스트림을 재생하거나 재생 대기열에 추가하도록 지시합니다.

#### Payload fields
| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `audioItem`               | object | 재생할 오디오 스트림의 메타 정보와 재생에 필요한 오디오 스트림 정보를 담고 있는 객체                     | 항상 |
| `audioItem.artImageUrl`   | string | 오디오 콘텐츠 관련 이미지(앨범 이미지)의 URI                                                  | 조건부  |
| `audioItem.audioItemId`   | string | 오디오 스트림 정보를 구분하는 ID. 클라이언트는 이 값을 기준으로 중복된 Play 지시 메시지를 제거할 수 있습니다. | 항상 |
| `audioItem.headerText`    | string | 주로 현재 재생 목록의 제목을 표현하는 텍스트 필드                                                | 조건부  |
| `audioItem.stream`        | [AudioStreamInfoObject](#AudioStreamInfoObject) | 재생에 필요한 오디오 스트림 정보를 담고 있는 객체        | 항상 |
| `audioItem.titleSubText1` | string | 주로 아티스트 이름을 표현하는 텍스트 필드                                                          | 항상 |
| `audioItem.titleSubText2` | string | 주로 앨범 이름을 표현하는 보조 텍스트 필드                                                      | 조건부 |
| `audioItem.titleText`     | string | 현재 음악의 제목을 표현하는 텍스트 필드                                                         | 항상  |
| `playBehavior`            | string | 지시 메시지에 포함된 오디오 스트림을 클라이언트에서 언제 재생할지를 결정하는 구분자 <ul><li><code>"REPLACE_ALL"</code>: 재생 대기열을 모두 비우고, 전달받은 오디오 스트림을 즉시 재생합니다.</li><li><code>"ENQUEUE"</code>: 재생 대기열에 전달받은 오디오 스트림을 추가합니다.</li></ul> | 항상 |
| `source`                  | object | 오디오 스트리밍 서비스의 출처 정보                                                    | 항상 |
| `source.logoUrl`          | string | 오디오 스트리밍 서비스의 로고 이미지의 URI. 이 필드 또는 필드의 값이 없거나 로고 이미지를 표시할 수 없으면 `source.name` 필드에 있는 오디오 스트리밍 서비스의 이름이라도 표시해야 합니다.  | 조건부 |
| `source.name`             | string | 오디오 스트리밍 서비스의 이름                                                        | 항상 |

#### Remarks
음악 서비스에서 과금과 같은 이유로 실제 스트리밍 정보, 즉 스트리밍 URI와 같은 정보는 재생 직전에 획득해야 할 수 있습니다. 이는 `audioItem.stream.urlPlayable` 필드 값에 따라 다음과 같이 구분됩니다.
* `urlPlayable` 필드 값이 `true`이면 `audioItem.stream.url` 필드에 포함된 URI로 오디오 스트림을 바로 재생할 수 있습니다.
* `urlPlayable` 필드 값이 `false`이면 `audioItem.stream.url` 필드에 포함된 URI로 오디오 스트림을 바로 재생할 수 없고 [`AudioPlayer.StreamRequested`](#StreamRequested) 이벤트 메시지를 사용하여 오디오 스트림 정보를 추가로 요청해야 합니다.

#### Message example
{% raw %}

```json
// 바로 재생 가능한 오디오 스트림 URI 정보가 담긴 예제
{
  "directive": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "Play",
      "dialogRequestId": "34abac3-cb46-611c-5111-47eab87b7",
      "messageId": "ad13f0d6-bb11-ca23-99aa-312a0b213805"
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
}

// 바로 재생 가능하지 않은 오디오 스트림 URI 정보가 담긴 예제
{
  "directive": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "Play",
      "dialogRequestId": "277b40c3-b046-4f61-a551-783b1547e7b7",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "audioItem": {
        "audioItemId": "9CPWU-8362fe7c-f75c-42c6-806b-6f3e00aba8f1-c1862201",
        "album": {
          "albumId": "2000240",
          "genres": [
            "Classic"
          ],
          "title": "Wonderland - Edvard Grieg : Piano Concerto, Lyric Pieces"
        },
        ...
        "stream": {
          "beginAtInMilliseconds": 0,
          "durationInMilliseconds": 60000,
          "progressReport": {
            "progressReportDelayInMilliseconds": null,
            "progressReportIntervalInMilliseconds": null,
            "progressReportPositionInMilliseconds": 60000
          },
          "token": "TR-NM-17716562",
          "url": "clova:TR-NM-17716562",
          "urlPlayable": false
        },
        "title": "Symphony No.4 In A Op.90 'Italian' - III. Con Moto Moderato",
        "type": "SampleMusicProvider"
      },
      "source": {
        "name": "Sample Music Provider",
        "logoUrl": "https://img.musicservice.example.net/logo_180125.png"
      },
      "playBehavior": "REPLACE_ALL"
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.PlayPaused`](#PlayPaused)
* [`AudioPlayer.PlayResumed`](#PlayResumed)
* [`AudioPlayer.PlayStarted`](#PlayStarted)
* [`AudioPlayer.PlayStopped`](#PlayStopped)
* [`AudioPlayer.ProgressReportDelayPassed`](#ProgressReportDelayPassed)
* [`AudioPlayer.ProgressReportIntervalPassed`](#ProgressReportIntervalPassed)
* [`AudioPlayer.ProgressReportPositionPassed`](#ProgressReportPositionPassed)
* [`AudioPlayer.StreamRequested`](#StreamRequested)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.PlayFinished -->

### AudioPlayer.PlayFinished event {#PlayFinished}
클라이언트가 오디오 스트림 재생을 완료할 때 재생 완료된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token    | 필수 |
| `offsetInMilliseconds` | number | 현재 클라이언트가 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "PlayFinished",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 183000
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.PlayStarted`](#PlayStarted)
* [`AudioPlayer.PlayStopped`](#PlayStopped)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.PlayPaused -->

### AudioPlayer.PlayPaused event {#PlayPaused}
클라이언트가 오디오 스트림 재생을 일시 정지할 때 일시 정지된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token | 필수 |
| `offsetInMilliseconds` | number | 현재 클라이언트가 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "PlayPaused",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 83100
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.PlayResumed`](#PlayResumed)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.PlayResumed -->

### AudioPlayer.PlayResumed event {#PlayResumed}

클라이언트가 오디오 스트림 재생을 재개할 때 재개된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token | 필수 |
| `offsetInMilliseconds` | number | 현재 클라이언트가 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "PlayResumed",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 83100
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.PlayPaused`](#PlayPaused)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.PlayStarted -->

### AudioPlayer.PlayStarted event {#PlayStarted}
클라이언트가 오디오 스트림 재생을 시작할 때 재생이 시작된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token | 필수 |
| `offsetInMilliseconds` | number | 현재 클라이언트가 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "PlayStarted",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 0
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.PlayStopped`](#PlayStopped)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.PlayStopped -->

### AudioPlayer.PlayStopped event {#PlayStopped}
클라이언트가 오디오 스트림 재생을 중지할 때 재생이 중지된 오디오 스트림 정보를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token | 필수 |
| `offsetInMilliseconds` | number | 현재 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "PlayStopped",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 83100
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.PlayStarted`](#PlayStarted)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.ProgressReportDelayPassed -->

### AudioPlayer.ProgressReportDelayPassed event {#ProgressReportDelayPassed}
오디오 스트림 재생이 시작된 후 지정된 지연 시간만큼 시간이 지났을 때 현재 재생 상태를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token | 필수 |
| `offsetInMilliseconds` | number | 현재 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "ProgressReportDelayPassed",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 60000
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.ProgressReportIntervalPassed`](#ProgressReportIntervalPassed)
* [`AudioPlayer.ProgressReportPositionPassed`](#ProgressReportPositionPassed)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.ProgressReportIntervalPassed -->

### AudioPlayer.ProgressReportIntervalPassed event {#ProgressReportIntervalPassed}
오디오 스트림 재생이 시작된 후 지정된 간격마다 현재 재생 상태를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token | 필수 |
| `offsetInMilliseconds` | number | 현재 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "ProgressReportIntervalPassed",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 120000
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.ProgressReportDelayPassed`](#ProgressReportDelayPassed)
* [`AudioPlayer.ProgressReportPositionPassed`](#ProgressReportPositionPassed)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.ProgressReportPositionPassed -->

### AudioPlayer.ProgressReportPositionPassed event {#ProgressReportPositionPassed}
오디오 스트림 재생이 시작된 후 지정된 보고 시점에 현재 재생 상태를 CIC로 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`                | string | 오디오 스트림 token | 필수 |
| `offsetInMilliseconds` | number | 현재 재생하고 있는 음원의 재생 시점. 단위는 밀리 초입니다.                         | 필수  |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "ProgressReportPositionPassed",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
      "token": "TR-NM-4435786",
      "offsetInMilliseconds": 150000
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.ProgressReportDelayPassed`](#ProgressReportDelayPassed)
* [`AudioPlayer.ProgressReportIntervalPassed`](#ProgressReportIntervalPassed)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.StreamDeliver -->

### AudioPlayer.StreamDeliver directive {#StreamDeliver}
[`AudioPlayer.StreamRequested`](#StreamRequested) 이벤트 메시지의 응답이며, 실제 음악 재생이 가능한 오디오 스트림 정보를 수신해야 할 때 사용합니다. 클라이언트가 음악을 재생할 수 있도록 오디오 스트림 정보에 스트리밍할 수 있는 URI 정보가 필수로 포함되어 있습니다.

#### Payload fields
| 필드 이름 | 자료형 | 필드 설명 | 포함 여부 |
|---------|------|--------|:---------:|
| `audioItemId` | string | 오디오 스트림 정보를 구분하는 값. 클라이언트는 이 값을 기준으로 중복된 Play 지시 메시지를 제거할 수 있습니다. | 항상 |
| `audioStream` | [AudioStreamInfoObject](#AudioStreamInfoObject) | 재생에 필요한 오디오 스트림 정보를 담고 있는 객체       | 항상 |

#### Remarks
`StreamDeliver` 지시 메시지를 통해 전달받는 `AudioStreamInfoObject` 객체는 기존 [`AudioPlayer.Play`](#Play) 지시 메시지를 통해 전달받은 `AudioStreamInfoObject` 객체의 내용과 중복을 피하기 위해 일부 내용이 생략될 수 있습니다. 따라서, 음원을 재생할 때 `StreamDeliver` 지시 메시지와 이미 수신한 [`Play`](#Play) 지시 메시지의 `payload.audioStream` 정보를 조합해서 사용해야 합니다.

#### Message example
{% raw %}

```json
{
  "directive": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "StreamDeliver",
      "dialogRequestId": "277b40c3-b046-4f61-a551-783b1547e7b7",
      "messageId": "4e4080d6-c440-498a-bb73-ae86c6312806"
    },
    "payload": {
        "audioItemId": "5313c879-25bb-461c-93fc-f85d95edf2a0",
        "stream": {
            "token": "b767313e-6790-4c28-ac18-5d9f8e432248",
            "url": "https://musicservice.example.net/b767313e.mp3"
        }
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.StreamRequested`](#StreamRequested)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.StreamRequested -->

### AudioPlayer.StreamRequested event {#StreamRequested}
오디오 스트림 재생을 위해 CIC로 스트리밍 URI와 같은 추가 정보를 요청하는 이벤트 메시지입니다.

#### Payload fields
| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `audioItemId`   | string  | 오디오 스트림 token          | 필수 |
| `audioStream`   | [AudioStreamInfoObject](#AudioStreamInfoObject) | Play 지시 메시지의 `audioItem.stream` | 필수 |

#### Remarks
음악 서비스의 과금을 고려하여 실제 오디오 스트림 정보 발급을 재생 직전으로 지연 해야 할 때가 있습니다. 이 이벤트 메시지는 이처럼 오디오 스트림 정보를 미리 준비하면 안될 때를 위해 설계된 API이며, 따라서 클라이언트는 이 이벤트 메시지를 재생 직전 시점보다 일찍 전달하면 안됩니다.

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "AudioPlayer",
      "name": "StreamRequested",
      "messageId": "198cf12-4020-b98a-b73b-1234ab312806"
    },
    "payload": {
      "audioItemId": "ac192f4c-8f12-4a58-8ace-e3127eb297a4",
      "audioStream": {
        "beginAtInMilliseconds": 0,
        "progressReport": {
            "progressReportDelayInMilliseconds": null,
            "progressReportIntervalInMilliseconds": null,
            "progressReportPositionInMilliseconds": 60000
        },
        "token": "TR-NM-4435786",
        "urlPlayable": false,
        "url": "clova:TR-NM-4435786"
      }
    }
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)

<!-- End of the shared content -->

<!-- Start of the shared content: PlaybackController.Pause -->

### PlaybackController.Pause directive {#Pause}
클라이언트에 재생 중인 오디오 스트림을 일시 정지하도록 지시합니다. 클라이언트는 이 지시 메시지를 받은 후 오디오 스트림 재생을 일시 정지해야 합니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| target            | object  | 제어 대상 정보를 가지는 객체. 이 지시 메시지를 통해 제어해야 하는 대상을 알 수 있습니다. | 조건부  |
| target.namespace  | string  | CIC API 네임스페이스. 제어 대상이 무엇인지 파악할 수 있는 정보입니다. 다음과 같은 값을 가질 수 있습니다.<ul><li><code>"AudioPlayer"</code>: 오디오 플레이어</li><li><code>"MediaPlayer"</code>: 미디어 플레이어</li></ul>  | 항상  |

#### Message example

```json
예제 1: 대상이 지정되지 않은 예제
{
  "directive": {
    "header": {
      "namespace": "PlaybackController",
      "name": "Pause",
      "dialogRequestId": "42390b12-ae91-4121-aa0a-37f74e8e422b",
      "messageId": "b1f88d7d-bbb8-44fa-a0a2-c5a7553e6f8a"
    },
    "payload": {}
  }
}

예제 2: 대상이 "AudioPlayer"로 지정된 예제
{
  "directive": {
    "header": {
      "namespace": "PlaybackController",
      "name": "Pause",
      "dialogRequestId": "a85e78b4-44f7-4bea-8a40-66c181b9720f",
      "messageId": "a76c8dfd-c1b6-44f6-a58d-fc8f33c242c1"
    },
    "payload": {
      "target": {
        "namespace": "AudioPlayer"
      }
    }
  }
}
```

#### See also
* [`AudioPlayer.PlayPaused`](#PlayPaused)

<!-- End of the shared content -->

<!-- Start of the shared content: PlaybackController.Resume -->

### PlaybackController.Resume directive {#Resume}
클라이언트에 오디오 스트림 재생을 재개하도록 지시합니다. 클라이언트는 이 지시 메시지를 받은 후 오디오 스트림 재생을 재개해야 합니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| target            | object  | 제어 대상 정보를 가지는 객체. 이 지시 메시지를 통해 제어해야 하는 대상을 알 수 있습니다. | 조건부  |
| target.namespace  | string  | CIC API 네임스페이스. 제어 대상이 무엇인지 파악할 수 있는 정보입니다. 다음과 같은 값을 가질 수 있습니다.<ul><li><code>"AudioPlayer"</code>: 오디오 플레이어</li><li><code>"MediaPlayer"</code>: 미디어 플레이어</li></ul>  | 항상  |

#### Message example

```json
// 예제 1: 대상이 지정되지 않은 예제
{
  "directive": {
    "header": {
      "namespace": "PlaybackController",
      "name": "Resume",
      "dialogRequestId": "42390b12-ae91-4121-aa0a-37f74e8e422b",
      "messageId": "b1f88d7d-bbb8-44fa-a0a2-c5a7553e6f8a"
    },
    "payload": {}
  }
}

// 예제 2: 대상이 "AudioPlayer"로 지정된 예제
{
  "directive": {
    "header": {
      "namespace": "PlaybackController",
      "name": "Resume",
      "dialogRequestId": "42390b12-ae91-4121-aa0a-37f74e8e422b",
      "messageId": "b1f88d7d-bbb8-44fa-a0a2-c5a7553e6f8a"
    },
    "payload": {
      "target": {
        "namespace": "AudioPlayer"
      }
    }
  }
}
```

#### See also
* [`AudioPlayer.PlayResumed`](#PlayResumed)

<!-- End of the shared content -->

<!-- Start of the shared content: PlaybackController.Stop -->

### PlaybackController.Stop directive {#Stop}
클라이언트에 오디오 스트림 재생을 중지하도록 지시합니다. 클라이언트는 이 지시 메시지를 받은 후 오디오 스트림 재생을 중지해야 합니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| target            | object  | 제어 대상 정보를 가지는 객체. 이 지시 메시지를 통해 제어해야 하는 대상을 알 수 있습니다. | 조건부  |
| target.namespace  | string  | CIC API 네임스페이스. 제어 대상이 무엇인지 파악할 수 있는 정보입니다. 다음과 같은 값을 가질 수 있습니다.<ul><li><code>"AudioPlayer"</code>: 오디오 플레이어</li><li><code>"MediaPlayer"</code>: 미디어 플레이어</li></ul>  | 항상  |

#### Message example

```json
// 예제 1: 대상이 지정되지 않은 예제
{
  "directive": {
    "header": {
      "namespace": "PlaybackController",
      "name": "Stop",
      "dialogRequestId": "42390b12-ae91-4121-aa0a-37f74e8e422b",
      "messageId": "b1f88d7d-bbb8-44fa-a0a2-c5a7553e6f8a"
    },
    "payload": {}
  }
}

// 예제 2: 대상이 "AudioPlayer"로 지정된 예제
{
  "directive": {
    "header": {
      "namespace": "PlaybackController",
      "name": "Stop",
      "dialogRequestId": "42390b12-ae91-4121-aa0a-37f74e8e422b",
      "messageId": "b1f88d7d-bbb8-44fa-a0a2-c5a7553e6f8a"
    },
    "payload": {
      "target": {
        "namespace": "AudioPlayer"
      }
    }
  }
}
```

#### See also
* [`AudioPlayer.PlayResumed`](#PlayResumed)

<!-- End of the shared content -->

<!-- Start of the shared content: SpeechSynthesizer.SpeechFinished -->

### SpeechSynthesizer.SpeechFinished event {#SpeechFinished}
클라이언트가 TTS 재생을 완료했음을 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`       | string  | TTS 식별용 token 값           | 항상    |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "SpeechSynthesizer",
      "name": "SpeechFinished",
      "messageId": "15472673-49a0-4aa1-8cf0-6355669ea473"
    },
    "payload": {
      "token": "cd14ad7a-9611-4b55-8ff5-c9097265950a"
    }
  }
}
```

{% endraw %}

#### See also
* [`SpeechSynthesizer.SpeechStarted`](#SpeechStarted)
* [`SpeechSynthesizer.SpeechStopped`](#SpeechStopped)

<!-- End of the shared content -->

<!-- Start of the shared content: SpeechSynthesizer.SpeechStarted -->

### SpeechSynthesizer.SpeechStarted event {#SpeechStarted}
클라이언트가 TTS 재생을 시작했음을 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`       | string  | TTS 식별용 token 값           | 항상    |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "SpeechSynthesizer",
      "name": "SpeechStarted",
      "messageId": "380c805c-0f19-4ed2-84e2-056f2f4016de"
    },
    "payload": {
      "token": "cd14ad7a-9611-4b55-8ff5-c9097265950a"
    }
  }
}
```

{% endraw %}

#### See also
* [`SpeechSynthesizer.SpeechFinished`](#SpeechFinished)
* [`SpeechSynthesizer.SpeechStopped`](#SpeechStopped)

<!-- End of the shared content -->

<!-- Start of the shared content: SpeechSynthesizer.SpeechStopped -->

### SpeechSynthesizer.SpeechStopped event {#SpeechStopped}
클라이언트가 TTS 재생을 중지했음을 보고하기 위해 사용됩니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`       | string  | TTS 식별용 token 값           | 항상    |

#### Message example
{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "SpeechSynthesizer",
      "name": "SpeechStopped",
      "messageId": "9a511e5c-4f20-413a-94cc-48172fc8710e"
    },
    "payload": {
      "token": "cd14ad7a-9611-4b55-8ff5-c9097265950a"
    }
  }
}
```

{% endraw %}

#### See also
* [`SpeechSynthesizer.SpeechFinished`](#SpeechFinished)
* [`SpeechSynthesizer.SpeechStarted`](#SpeechStarted)

<!-- End of the shared content -->

<!-- Start of the shared content: TemplateRuntime.RenderPlayerInfo -->

### TemplateRuntime.RenderPlayerInfo directive {#RenderPlayerInfo}

CIC가 클라이언트에 미디어 플레이어에 표시할 재생 목록, 앨범 이미지, 가사와 같은 재생 메타 정보를 전달하고 이를 표시하도록 지시합니다. 사용자가 음악 재생을 요청하면 클라이언트는 [`AudioPlayer.Play`](#Play) 지시 메시지를 받아 미디어를 재생하게 됩니다. 디스플레이 장치가 있는 클라이언트라면 필요에 따라 미디어 플레이어에 재생 관련 정보를 표현해야 할 수 있습니다. 이때, [`TemplateRuntime.RequestPlayerInfo`](#RequestPlayerInfo) 이벤트 메시지를 통해 재생 메타 정보를 CIC에 요청할 수 있으며, `TemplateRuntime.RenderPlayerInfo` 지시 메시지를 수신할 수 있습니다. `TemplateRuntime.RenderPlayerInfo` 지시 메시지는 현재 재생해야 하는 미디어 콘텐츠와 추후 재생해야 하는 미디어 콘텐츠의 재생 메타 정보를 담고 있습니다. 클라이언트는 `TemplateRuntime.RenderPlayerInfo` 지시 메시지의 재생 메타 정보를 사용자에게 제공하므로써 현재 재생 미디어의 메타 정보 및 재생 목록을 표시할 수 있습니다.

#### Payload fields
| 필드 이름       | 자료형    | 필드 설명                     | 포함 여부 |
|---------------|---------|-----------------------------|:---------:|
| `displayType`               | string | 미디어 콘텐츠 표시 형태.<ul><li><code>"list"</code>: 목록 표시 형태</li><li><code>"single"</code>: 단일 항목 표시 형태</li></ul>       | 항상 |
| `controls[]`                | object array | 클라이언트가 미디어 플레이어에서 반드시 표시해야 버튼의 정보를 담고 있는 객체 배열입니다.             | 항상 |
| `controls[].enabled`        | boolean      | `controls[].name`에 명시된 버튼이 미디어 플레이어에서 활성화되어야 하는지 나타냅니다.<ul><li><code>true</code>: 활성화</li><li><code>false</code>: 비활성화</li></ul>  | 항상  |
| `controls[].name`           | string       | 버튼 이름. 다음과 같은 값이 포함될 수 있습니다.<ul><li><code>"NEXT"</code>: 다음 버튼</li><li><code>"PLAY_PAUSE"</code>: 재생/일시 정지 버튼</li><li><code>"PREVIOUS"</code>: 이전 버튼</li></ul>  | 항상  |
| `controls[].selected`       | boolean      | 미디어 콘텐츠가 선택된 상태 여부. 이 값은 선호 항목의 개념이 들어간 것을 표현할 때 사용될 수 있습니다. 이 값이 `true`로 선택되었다면 사용자가 선호 항목으로 등록해둔 콘텐츠이기 때문에 미디어 플레이어에서 관련된 UI에 표현해야 합니다. <ul><li><code>true</code>: 선택됨</li><li><code>false</code>: 선택 안됨</li></ul> | 항상  |
| `controls[].type`           | string       | 버튼의 타입. 현재는 `"BUTTON"` 값만 사용됩니다.  | 항상 |
| `playableItems[]`           | object array | 재생할 수 있는 미디어 콘텐츠 목록의 정보를 담고 있는 객체 배열입니다. 이 필드는 빈 배열일 수 있습니다.  | 항상 |
| `playableItems[].artImageUrl`  | string    | 미디어 콘텐츠 관련 이미지의 URI. 앨범 자켓 이미지나 관련 아이콘 이미지가 위치한 URI입니다.      | 조건부 |
| `playableItems[].controls[]`                | object array  | 특정 미디어 콘텐츠를 재생할 때 반드시 표시해야 하는 버튼의 정보를 담고 있는 객체 배열입니다. 이 객체 배열을 생략될 수 있습니다.  | 조건부 |
| `playableItems[].controls[].enabled`        | boolean      | `playableItems[].controls[].name`에 명시된 버튼이 미디어 플레이어에서 활성화되어야 하는지 나타냅니다.<ul><li><code>true</code>: 활성화</li><li><code>false</code>: 비활성화</li></ul>  | 항상  |
| `playableItems[].controls[].name`           | string       | 버튼 또는 제어 UI의 이름. 다음과 같은 값이 포함될 수 있습니다.<ul><li><code>"BACKWARD_15S"</code>: 15 초 뒤로 이동 버튼</li><li><code>"BACKWARD_30S"</code>: 30 초 뒤로 이동 버튼</li><li><code>"BACKWARD_60S"</code>: 60 초 뒤로 이동 버튼</li><li><code>"FORWARD_15S"</code>: 15 초 앞으로 이동 버튼</li><li><code>"FORWARD_30S"</code>: 30 초 앞으로 이동 버튼</li><li><code>"FORWARD_60S"</code>: 60 초 앞으로 이동 버튼</li><li><code>"MORE"</code>: 더보기 버튼</li><li><code>"NEXT"</code>: 다음 버튼</li><li><code>"PLAY_PAUSE"</code>: 재생/일시 정지 버튼</li><li><code>"PREVIOUS"</code>: 이전 버튼</li><li><code>"PROGRESS_BAR"</code>: 진행 표시줄</li><li><code>"REPEAT"</code>: 반복 버튼</li><li><code>"SUBSCRIBE_UNSUBSCRIBE"</code>: 구독/구독 취소 버튼</li></ul>  | 항상  |
| `playableItems[].controls[].selected`       | boolean      | 미디어 콘텐츠가 선택된 상태 여부. 이 값은 선호 항목의 개념이 들어간 것을 표현할 때 사용될 수 있습니다. 이 값이 `true`로 선택되었다면 사용자가 선호 항목으로 등록해둔 콘텐츠이기 때문에 미디어 플레이어에서 관련된 UI에 표현해야 합니다. <ul><li><code>true</code>: 선택됨</li><li><code>false</code>: 선택 안됨</li></ul> | 항상  |
| `playableItems[].controls[].type`           | string       | 버튼의 타입. 현재는 `"BUTTON"` 값만 사용됩니다.  | 항상 |
| `playableItems[].headerText`       | string        | 주로 현재 재생 목록의 제목을 표현하는 텍스트 필드                                                | 조건부  |
| `playableItems[].isLive`           | boolean       | 실시간 콘텐츠 여부.<ul><li><code>true</code>: 실시간 콘텐츠</li><li><code>false</code>: 실시간 콘텐츠 아님</li></ul><div class="note"><p><strong>Note!</strong></p><p>실시간 콘텐츠이면 실시간 콘텐츠임을 의미하는 아이콘(예: live 아이콘)을 표시해야 합니다.</p></div>  | 조건부  |
| `playableItems[].lyrics[]`         | object array  | 가사 정보를 담고 있는 객체 배열.                                                            | 조건부  |
| `playableItems[].lyrics[].data`    | string        | 가사 데이터. 이 필드 또는 `playableItems[].lyrics[].url` 필드 중 하나는 존재합니다.              | 조건부  |
| `playableItems[].lyrics[].format`  | string        | 가사 데이터의 포맷.<ul><li><code>"LRC"</code>: <a href="https://en.wikipedia.org/wiki/LRC_(file_format)" target="_blank">LRC 포맷</a></li><li><code>"PLAIN"</code>: 일반 텍스트 형식</li></ul>  | 항상  |
| `playableItems[].lyrics[].url`     | string        | 가사 데이터의 URI. 이 필드 또는 `playableItems[].lyrics[].data` 필드 중 하나는 존재합니다.        | 조건부  |
| `playableItems[].showAdultIcon`    | boolean       | 성인용 콘텐츠를 나타내는 아이콘의 표시 여부.<ul><li><code>true</code>: 표시해야 함.</li><li><code>false</code>: 표시 안해야 함.</li></ul>   | 항상  |
| `playableItems[].titleSubText1`    | string        | 주로 아티스트 이름을 표현하는 텍스트 필드                                                          | 항상 |
| `playableItems[].titleSubText2`    | string        | 주로 앨범 이름을 표현하는 보조 텍스트 필드                                                      | 조건부 |
| `playableItems[].titleText`        | string        | 현재 음악의 제목을 표현하는 텍스트 필드                                                         | 항상  |
| `playableItems[].token`            | string        | 미디어 콘텐츠의 token                                                                     | 항상 |
| `provider`                         | object        | 미디어 콘텐츠 제공자의 정보가 담긴 객체                                                         | 조건부 |
| `provider.logoUrl`                 | string        | 미디어 콘텐츠 제공자 로고 이미지의 URI. 이 필드 또는 필드의 값이 없거나 로고 이미지를 표시할 수 없으면 `provider.name` 필드에 있는 미디어 콘텐츠 제공자의 이름이라도 표시해야 합니다. | 조건부 |
| `provider.name`                    | string        | 미디어 콘텐츠 제공자의 이름                                                                   | 항상  |
| `provider.smallLogoUrl`            | string        | 크기가 작은 미디어 콘텐츠 제공자 로고 이미지의 URI                                                | 조건부 |

#### Message example
{% raw %}

```json
{
  "directive": {
    "header": {
      "namespace": "TemplateRuntime",
      "name": "RenderPlayerInfo",
      "dialogRequestId": "34abac3-cb46-611c-5111-47eab87b7",
      "messageId": "ad13f0d6-bb11-ca23-99aa-312a0b213805"
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
          "token": "eJyr5lIqSSyITy4tKs4vUrJSUE="
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
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`TemplateRuntime.RequestPlayerInfo`](#RequestPlayerInfo)

<!-- End of the shared content -->

<!-- Start of the shared content: TemplateRuntime.RequestPlayerInfo -->

### TemplateRuntime.RequestPlayerInfo event {#RequestPlayerInfo}
클라이언트가 미디어 플레이어에 표시할 재생 목록, 앨범 이미지, 가사와 같은 재생 메타 정보를 CIC에 요청합니다.

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `token`        | string  | 재생 메타 정보를 가져올 때 시작 기준이 되는 오디오 스트림 token. | 필수 |
| `range`        | object  | 재생 메타 정보의 범위를 지정하는 객체. 이 필드가 사용되지 않으면 클라이언트는 임의의 개수만큼 메타 정보를 수신하게 됩니다.   | 선택  |
| `range.before` | number  | 기준 미디어 콘텐츠로부터 n개만큼 이전 재생 목록에 포함되는 재생 메타 정보를 요청합니다.  | 선택  |
| `range.after`  | number  | 기준 미디어 콘텐츠로부터 n개만큼 다음 재생 목록에 포함되는 재생 메타 정보를 요청합니다. 예를 들어, `range.before` 필드의 값을 지정하지 않고 `range.after`의 값을 `5`로 설정하면 기준 미디어 콘텐츠를 포함한 총 6 개의 미디어 콘텐츠에 해당하는 재생 메타 정보를 수신하게 됩니다. | 선택  |

#### Message example

{% raw %}

```json
{
  "context": [
    ...
  ],
  "event": {
    "header": {
      "namespace": "TemplateRuntime",
      "name": "RequestPlayerInfo",
      "messageId": "2fcb6a62-393d-46ad-a5c4-b3db9b640045"
    },
    "payload": {
      "token": "eJyr5lIqSSyITy4tKs4vUrJSUE"
    }
  }
}
```
{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)

### AudioStreamInfoObject {#AudioStreamInfoObject}
재생할 음악의 오디오 스트림의 스트리밍 정보를 담고 있는 객체입니다. 클라이언트에 재생할 스트리밍 정보를 전달하거나 클라이언트가 CIC로 현재 재생 중인 음악의 스트리밍 정보를 전달해야 할 때 사용합니다.

#### Object fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수/포함 여부 |
|---------------|---------|-----------------------------|:-------------:|
| `beginAtInMilliseconds`  | number | 재생을 시작할 지점. 단위는 밀리초이며, 이 값이 지정되면 클라이언트는 해당 오디오 스트림을 지정된 위치부터 재생해야 합니다. 이 값이 0이면 해당 스트림을 처음부터 재생해야 합니다.          | 필수/항상 |
| `customData`             | string | 현재 음원과 관련하여 임의의 형식을 가지는 메타 데이터 정보. 특정 범주로 분류되거나 정의될 수 없는 스트리밍 정보는 이 필드에 포함되거나 입력되어야 합니다. 오디오 스트림 재생 문맥에 추가로 필요한 값을 서비스 제공자 임의대로 추가할 수 있습니다.<div class="warning"><p><strong>Warning!</strong></p><p>이 필드의 값을 클라이언트가 임의로 이용해서는 안되며 이는 문제를 발생시킬 수 있습니다. 또한, 이 필드 값은 오디오 재생 상태를 전달할 때 <a href="{{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/Context_Objects.{{ book.DocMeta.FileExtensionForExternalLink }}#PlaybackState">PlaybackState 문맥 정보</a>의 `stream` 필드에 그대로 첨부되어야 합니다.</p></div> | 선택/조건부  |
| `durationInMilliseconds` | number | 오디오 스트림의 재생 시간. 클라이언트는 `beginAtInMilliseconds` 필드에 지정된 재생 시작 시점부터 이 필드에 지정된 재생 시간만큼 해당 오디오 스트림을 탐색 및 재생할 수 있습니다. 예를 들면, `beginAtInMilliseconds` 필드의 값이 `10000`이고, 이 필드의 값이 `60000`이면 해당 오디오 스트림의 10 초부터 70 초까지의 구간을 재생 및 탐색할 수 있게 됩니다. 단위는 밀리 초입니다.   | 선택/조건부  |
| `format`                 | string  | 미디어 포맷(MIME 타입). 이 필드를 통해 HLS(HTTP Live Streaming) 방식의 콘텐츠인지 구분할 수 있습니다. 다음과 같은 값을 가질 수 있습니다. 기본 값은 `"audio/mpeg"`입니다.<ul><li><code>"audio/mpeg"</code></li><li><code>"audio/mpegurl"</code></li><li><code> "audio/aac"</code></li><li><code>"application/vnd.apple.mpegurl"</code></li></ul> <div class="note"><p><strong>Note!</strong></p><p>HLS 방식으로 콘텐츠를 제공하려는 extension 개발자는 <a href="mailto:{{ book.ServiceEnv.ExtensionAdminEmail }}">{{ book.ServiceEnv.ExtensionAdminEmail }}</a>로 연락합니다.</p></div>   | 선택/조건부  |
| `progressReport`         | object  | 재생 후 재생 상태 정보를 보고 받기 위해 보고 시간을 정해둔 객체                                                  | 선택/조건부 |
| `progressReport.progressReportDelayInMilliseconds`    | number | 재생 시작 후 지정된 시간이 지났을 때 재생 상태 정보를 보고받기 위해 지정되는 값입니다. 단위는 밀리 초이며, 이 필드는 null 값을 가질 수 있습니다.  | 선택/조건부 |
| `progressReport.progressReportIntervalInMilliseconds` | number | 재생 중 지정된 시간 간격으로 재생 상태 정보를 보고받기 위해 지정되는 값입니다. 단위는 밀리 초이며, 이 필드는 null 값을 가질 수 있습니다.        | 선택/조건부 |
| `progressReport.progressReportPositionInMilliseconds` | number | 재생 중 지정된 시점을 지날 때마다 재생 상태 정보를 보고받기 위해 지정되는 값입니다. 단위는 밀리 초이며, 이 필드는 null 값을 가질 수 있습니다.    | 선택/조건부 |
| `token`                  | string  | 오디오 스트림 token.<div class="note"><p><strong>Note!</strong></p><p>이 필드의 최대 길이는 2048 바이트입니다.</p></div>                          | 필수/항상 |
| `url`                    | string  | 오디오 스트림 URL.<div class="note"><p><strong>Note!</strong></p><p>이 필드의 최대 길이는 2048 바이트입니다.</p></div>                              | 필수/항상 |
| `urlPlayable`            | boolean | `url` 필드의 오디오 스트림 URI가 바로 재생 가능한 형태인지 구분하는 값. <ul><li><code>true</code>: 바로 재생이 가능한 형태의 URI</li><li><code>false</code>: 바로 재생이 불가능한 형태의 URI. <a href="#StreamRequested"><code>AudioPlayer.StreamRequested</code></a> 이벤트 메시지를 사용하여 오디오 스트림 정보를 추가로 요청해야 합니다.</li></ul>        | 필수/항상 |

#### Remarks
* 클라이언트는 `beginAtInMilliseconds`와 `durationInMilliseconds` 필드에 지정된 구간에 대해 음악 재생을 완료하면 [`AudioPlayer.PlayFinished`](#PlayFinished) 이벤트 메시지를 CIC로 전송합니다.

#### Object Example
{% raw %}

```json
// 바로 재생 가능한 오디오 스트림 URI 정보가 담긴 객체
{
  "beginAtInMilliseconds": 0,
  "episodeId": 22346122,
  "playType": "NONE",
  "podcastId": 12548,
  "progressReport": {
    "progressReportDelayInMilliseconds": null,
    "progressReportIntervalInMilliseconds": 60000,
    "progressReportPositionInMilliseconds": null
  },
  "url": "https://streaming.example.com/file/12548/22346122",
  "urlPlayable": true
}

// 바로 재생 가능하지 않은 오디오 스트림 URI 정보가 담긴 예제
{
  "beginAtInMilliseconds": 0,
  "progressReport": {
      "progressReportDelayInMilliseconds": null,
      "progressReportIntervalInMilliseconds": null,
      "progressReportPositionInMilliseconds": 60000
  },
  "token": "TR-NM-4435786",
  "urlPlayable": false,
  "url": "clova:TR-NM-4435786"
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.PlayFinished`](#PlayFinished)
* [`AudioPlayer.StreamRequested`](#StreamRequested)

<!-- End of the shared content -->

<!-- Start of the shared content: AudioPlayer.PlaybackState -->

## 오디오 콘텐츠 재생 관련 맥락 정보 {#ContextObjectforAudioPlayback}
클라이언트가 CLOVA에 [CIC API](#CICAPIforAudioPlayback) 이벤트 메시지를 전송할 때 다음과 같은 다양한 맥락 정보(context)를 보냅니다. 이 중 오디오 콘텐츠 재생과 관련된 맥락 정보는 [`AudioPlayer.PlaybackState`](#PlaybackState) 입니다.

### AudioPlayer.PlaybackState {#PlaybackState}
`AudioPlayer.PlaybackState`는 현재 재생하고 있거나 마지막으로 재생한 미디어 정보를 CIC에 보고할때 사용하는 메시지 포맷입니다.

#### Object structure

{% raw %}
```json
{
  "header": {
    "namespace": "AudioPlayer",
    "name": "PlaybackState"
  },
  "payload": {
    "offsetInMilliseconds": {{number}},
    "playerActivity": {{string}},
    "repeatMode": {{string}},
    "stream": {{AudioStreamInfoObject}},
    "totalInMilliseconds": {{number}}
  }
}
```
{% endraw %}

#### Payload fields

| 필드 이름       | 자료형    | 필드 설명                     | 필수 여부 |
|---------------|---------|-----------------------------|:---------:|
| `offsetInMilliseconds` | number | 최근 재생 미디어의 마지막 재생 지점(offset). 단위는 밀리초이며, `playerActivity` 값이 `"IDLE"`이면 이 필드 값은 입력하지 않아도 됩니다.                                                  | 선택 |
| `playerActivity`       | string | 플레이어의 상태를 나타내는 값이며 다음과 같은 값을 가집니다.<ul><li><code>"IDLE"</code>: 비활성 상태</li><li><code>"PLAYING"</code>: 재생 중인 상태</li><li><code>"PAUSED"</code>: 일시 정지 상태</li><li><code>"STOPPED"</code>: 중지 상태</li></ul> | 필수 |
| `repeatMode`           | string  | 반복 재생 모드.<ul><li><code>"NONE"</code>: 반복 재생 안함</li><li><code>"REPEAT_ONE"</code>: 한 곡 반복 재생</li></ul>                                                   | 필수  |
| `stream`               | [AudioStreamInfoObject](#AudioStreamInfoObject) | 재생 중인 미디어의 상세 정보를 보관한 객체. `playerActivity` 값이 `"IDLE"`이면 이 필드 값은 입력하지 않아도 됩니다. [`AudioPlayer.Play`](#Play) 또는 [`AudioPlayer.StreamDeliver`](#StreamDeliver) 지시 메시지로 전달되었던 미디어 정보(`stream` 객체)의 값을 입력합니다. | 선택 |
| `totalInMilliseconds`  | number | 최근 재생 미디어의 전체 길이. [`AudioPlayer.Play`](#Play) 지시 메시지를 통해 전달받은 오디오 정보([AudioStreamInfoObject](#AudioStreamInfoObject))에 `durationInMilliseconds` 필드 값이 있으면 이 필드의 값으로 입력하면 됩니다. 단위는 밀리초이며, `playerActivity` 값이 `"IDLE"`이면 이 필드 값은 입력하지 않아도 됩니다.                                                               | 선택 |

#### Object example

{% raw %}

```json
// Case 1: 재생이 중지된 상태
{
  "header": {
    "namespace": "AudioPlayer",
    "name": "PlaybackState"
  },
  "payload": {
    "offsetInMilliseconds": 10000,
    "totalInMilliseconds": 300000,
    "playerActivity": "STOPPED",
    "repeatMode": "NONE",
    "stream": {
      "beginAtInMilliseconds": 0,
      "progressReport": {
        "progressReportDelayInMilliseconds": null,
        "progressReportIntervalInMilliseconds": null,
        "progressReportPositionInMilliseconds": 60000
      },
      "token": "TR-NM-17740107",
      "url": "clova:TR-NM-17740107",
      "urlPlayable": false
    }
  }
}

// 예제 2: 플레이어가 비활성화된 상태
{
  "header": {
    "namespace": "AudioPlayer",
    "name": "PlaybackState"
  },
  "payload": {
    "playerActivity": "IDLE",
    "repeatMode": "NONE"
  }
}
```

{% endraw %}

#### See also
* [`AudioPlayer.Play`](#Play)
* [`AudioPlayer.StreamDeliver`](#StreamDeliver)
* [`AudioPlayer.StreamRequested`](#StreamRequested)

<!-- End of the shared content -->

{% endif %}
