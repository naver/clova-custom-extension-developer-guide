## Custom extension 요청 처리하기 {#HandleCustomExtensionRequest}
Custom extension은 CLOVA로부터 [custom extension 메시지](/Develop/References/Custom_Extension_Message.md) 형태의 사용자 요청을 수신합니다(HTTP Request). Custom extension은 일반적으로 다음과 같이 요청을 처리하고 응답해야 합니다.

![CEK_Custom_Extension_Sequence_Diagram](/Develop/Assets/Images/CEK_Custom_Extension_Sequence_Diagram.svg)

이를 위해 사용자의 요청을 세 가지 타입의 요청으로 구분하고 있습니다. Custom extension 개발자는 각 메시지에 따라 그에 상응하는 작업을 처리해야 합니다.
세 가지 요청 타입과 각 요청 타입의 사용자 발화 패턴은 다음과 같습니다.

| 요청 타입 | 사용자 발화 패턴 | 발화 예시 |
|---------|--------------|---------|
|[LaunchRequest](#HandleLaunchRequest) | _[extension 호출 이름]_ + "시작해줘/열어줘/동작해줘" | "피자봇 시작해줘" |
| [IntentRequest](#HandleIntentRequest) | _[extension 호출 이름]_ + "에게/에서/한테/로" + _[extension 별로 등록한 실행 명령어]_, 혹은 <br/>(`LaunchRequest` 타입 요청 받은 상태에서) _[extension 별로 등록한 실행 명령어]_ | "피자봇에서 피자 시켜줘" <br/> (피자봇 시작 상태에서) "주문 조회해줘" |
| [SessionEndedRequest](#HandleSessionEndedRequest) | (`LaunchRequest` 타입 요청 받은 상태에서) "종료해줘/종료/그만" | "(피자봇) 종료해줘" |

<div class="tip">
<p><strong>Tip!</strong></p>
<p><a href="/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest"><code>EventRequest</code></a> 요청 타입은 사용자의 발화 보다는 주로 클라이언트 상태 변화에 의해 extension으로 전달되는 메시지입니다. 클라이언트 상태에 대한 정보 수집 및 클라이언트 상태 변화에 대한 extension의 대응을 위해 사용되며, extension이 <a href="/Develop/Guides/Provide_Audio_Content.md">오디오 콘텐츠를 제공</a>할 때 사용됩니다. 따라서 이 절에서는 <code>EventRequest</code>에 대해서 다루지 않습니다.</p>
</div>

### LaunchRequest 요청 처리 {#HandleLaunchRequest}
[`LaunchRequest` 타입](/Develop/References/Custom_Extension_Message.md#CustomExtLaunchRequest) 요청은 사용자가 특정 extension을 사용하기로 선언한 것을 알릴 때 사용됩니다. 예를 들어, 사용자가 "피자봇 시작해줘"나 "피자봇 열어줘"와 같은 명령을 내렸다면 CLOVA는 피자 배달 서비스를 제공하는 extension에 `LaunchRequest` 타입 요청을 전달합니다. 이 요청 타입을 수신한 extension은 사용자의 다음 요청을 수신할 수 있도록 준비해야 합니다.

LaunchRequest 타입 메시지는 `request.type` 필드에 `"LaunchRequest"`라는 값을 가지며 `request` 필드에 사용자의 발화가 분석된 정보를 포함하고 있지 않습니다. Extension 개발자는 이 메시지를 받은 후 사전 준비 사항을 처리하거나 사용자에게 서비스를 제공할 준비가 되었다는 [응답 메시지](#ReturnCustomExtensionResponse)를 보내면 됩니다.

이 메시지를 받은 후부터 [`SessionEndedRequest` 타입](#HandleSessionEndedRequest) 요청 메시지를 받기 전까지 [`IntentRequest` 타입](#HandleIntentRequest)의 요청 메시지를 받게 되며, `session.sessionId` 필드는 이전 메시지와 같은 값을 가지게 됩니다.

다음은 `LaunchRequest` 타입의 요청 메시지 예입니다.

{% raw %}
```json
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
```
{% endraw %}

위 예제에서 각 필드의 의미는 다음과 같습니다.

* `version`: 현재 사용하는 custom extension 메시지 포맷의 버전이 v0.1.0입니다.
* `session`: **새로운 세션이며**, 새로운 세션에 사용될 세션의 ID와 사용자의 정보(ID, accessToken)가 담겨 있습니다.
* `context`: 클라이언트 기기에 대한 정보이며, 기기 ID와 기기의 기본 사용자 정보가 담겨 있습니다.
* `request`: `LaunchRequest` 타입 요청으로 대상 extension의 사용 시작을 알립니다. 사용자의 발화가 분석된 정보는 없습니다.

### IntentRequest 요청 처리 {#HandleIntentRequest}

[`IntentRequest` 타입 요청](/Develop/References/Custom_Extension_Message.md#CustomExtIntentRequest)은 CLOVA가 미리 정의해 둔 [interaction 모델](/Design/Design_Custom_Extension.md#DefineInteractionModel)에 따라 사용자의 요청을 extension에 전달할 때 사용됩니다. `IntentRequest`는 사용자가 extension 호출 이름을 지정하여 명령을 내리거나, `LaunchRequest` 발생 이후 호출 이름 없이 명령을 내릴 때 extension으로 전달됩니다. 예를 들어, 사용자가 "피자봇에서 피자 시켜줘"나, 별도의 명령으로 서비스를 시작한 후 "피자 주문해 달라고 해"와 같은 명령을 내렸다면 CLOVA는 피자 배달 서비스를 제공하는 extension에 `IntentRequest` 타입 요청을 전달합니다. `IntentRequest` 타입 요청은 일회적인 요청뿐만 아니라 [연속되는 사용자 요청(Multi-turn request)을 처리](/Develop/Guides/Do_Multiturn_Dialog.md)할 때도 사용됩니다.

IntentRequest 타입 메시지는 `request.type` 필드에 `"IntentRequest"`라는 값을 가집니다. 호출된 intent의 이름과 분석된 사용자의 발화 정보는 `request.intent` 필드를 통해 확인할 수 있습니다. 이 필드를 분석하여 사용자의 요청을 처리한 후 [응답 메시지](#ReturnCustomExtensionResponse)를 보내면 됩니다.

다음은 `IntentRequest` 타입의 요청 메시지 예입니다.

{% raw %}
```json
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
```
{% endraw %}

위 예제에서 각 필드의 의미는 다음과 같습니다.

* `version`: 현재 사용하는 custom extension 메시지 포맷의 버전이 v0.1.0입니다.
* `session`: **기존 세션에 이어지는 사용자의 요청이며**, 기존 세션의 ID와 사용자의 정보(ID, accessToken)가 담겨 있습니다.
* `context`: 클라이언트 기기에 대한 정보이며, 기기 ID와 기기의 기본 사용자 정보가 담겨 있습니다.
* `request`: `IntentRequest` 타입 요청이며, `"OrderPizza"`라는 이름으로 등록된 [intent](/Design/Design_Custom_Extension.md#Intent)를 호출했습니다. 해당 intent의 필요 정보로 `"pizzaType"`라는 [slot](/Design/Design_Custom_Extension.md#Slot)이 함께 전달되었고 해당 slot은 `"페퍼로니"`라는 값을 가지고 있습니다.

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p><code>IntentRequest</code> 타입 요청은 <code>LaunchRequest</code> 타입 요청과 상관없이 없이 새로운 세션을 시작하여 요청을 처리할 수 있습니다.</p>
</div>

### SessionEndedRequest 요청 처리 {#HandleSessionEndedRequest}

[`SessionEndedRequest` 타입 요청](/Develop/References/Custom_Extension_Message.md#CustomExtSessionEndedRequest)은 사용자가 특정 모드나 특정 custom extension의 사용을 중지하기로 선언한 것을 알릴 때 사용됩니다. 사용자가 "종료해줘"나 "그만"과 같은 명령을 내리면 CLOVA는 대화 서비스를 제공하는 extension에 `SessionEndedRequest` 타입 요청을 전달합니다.

`SessionEndedRequest` 타입 메시지는 `request.type` 필드에 `"SessionEndedRequest"`라는 값을 가지며 `LaunchRequest` 타입과 마찬가지로 `request` 필드에 사용자의 발화가 분석된 정보를 포함하고 있지 않습니다. Extension 개발자는 서비스를 종료하면 됩니다.

다음은 `SessionEndedRequest` 타입의 요청 메시지 예입니다.


{% raw %}
```json
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

위 예제에서 각 필드의 의미는 다음과 같습니다.

* `version`: 현재 사용하는 custom extension 메시지 포맷의 버전이 v0.1.0입니다.
* `session`: **기존 세션에 이어지는 사용자의 요청이며**, 기존 세션의 ID와 사용자의 정보(ID, accessToken)가 담겨 있습니다.
* `context`: 클라이언트 기기에 대한 정보이며, 기기 ID와 기기의 기본 사용자 정보가 담겨 있습니다.
* `request`: `SessionEndedRequest` 타입 요청으로 대상 extension의 사용을 중지했음을 알립니다. 사용자의 발화가 분석된 정보는 없습니다.

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>CLOVA가 <code>SessionEndedRequest</code> 타입 요청을 extension에 전송한 순간부터 CLOVA는 해당 extension의 응답을 모두 무시합니다.</p>
</div>
