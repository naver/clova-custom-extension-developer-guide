# Multi-turn 대화 수행하기

CEK로부터 전달받은 사용자 요청 정보([`IntentRequest`](/Develop/Guides/Build_Custom_Extension.md#HandleIntentRequest))가 custom extension이 서비스를 제공하거나 동작을 수행하기에 부족할 수도 있습니다. 또는 Single-turn 형태의 대화로 사용자의 요청을 한번에 받기 어려울 수 있습니다. 이때 custom extension은 사용자에게 부족한 정보를 추가로 받기 위해 multi-turn 대화를 수행할 수 있습니다. Multi-turn 대화의 기본적인 동작 구조는 다음과 같습니다.

![CEK_Custom_Extension_Multi-turn_Sequence_Diagram](/Develop/Assets/Images/CEK_Custom_Extension_Multi-turn_Sequence_Diagram.svg)

예를 들면, 사용자가 "페퍼로니 피자 주문해줘"라고 했고 CEK에서 아래와 같은 요청 메시지를 보냈다고 가정해 봅니다.

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
    ...
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

Custom extension에서 피자 종류뿐만 아니라 주문 수량 정보가 추가로 필요할 수도 있습니다. 이때, [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)의 `response.shouldEndSession` 필드를 `false`로 설정하면, 부족한 정보를 추가로 확인하기 위해 multi-turn 대화를 시도할 수 있습니다. 또한, 기존에 사용자가 먼저 보냈던 정보를 `sessionAttributes` 필드에 키(key)-값(value) 형태로 저장해둘 수 있습니다.

아래와 같이 응답하면 사용자가 이미 요청했던 `intent` 필드와 `pizzaType`의 정보를 보관해두도록 CLOVA에 요청할 수 있으며, 사용자에게 수량과 관련된 추가 정보를 요청할 수 있습니다.

{% raw %}
```json
{
  "version": "0.1.0",
  "sessionAttributes": {
    "intent": "OrderPizza",
    "pizzaType": "페퍼로니"
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
```
{% endraw %}

추후 사용자가 필요한 수량 정보까지 응답하면 다음과 같이 분석된 수량 정보와 함께 CLOVA 플랫폼은 저장해둔 `sessionAttributes` 객체 정보를 [요청 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtRequestMessage)의 `session.sessionAttributes` 필드에 포함하여 다시 전달합니다. 이때, 추가로 전달된 메시지는 이전 메시지와 같은 `session.sessionId` 값을 가지게 되며, custom extension은 받은 추가 정보를 이용하여 다음 동작을 수행하면 됩니다.

{% raw %}
```json
{
  "version": "0.1.0",
  "session": {
    "new": false,
    "sessionAttributes": {
        "intent": "OrderPizza",
        "pizzaType": "페퍼로니"
    },
    "sessionId": "a29cfead-c5ba-474d-8745-6c1a6625f0c5",
    "user": {
      "userId": "V0qe",
      "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
    }
  },
  "context": {
    ...
  },
  "request": {
    "type": "IntentRequest",
    "intent": {
      "name": "AddInfo",
      "slots": {
        "pizzaAmount": {
          "name": "pizzaAmount",
          "value": "2"
        }
      }
    }
  }
}
```
{% endraw %}

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>Extension이 <a href="#HandleSessionEndedRequest"><code>SessionEndedRequest</code> 타입 요청</a>을 받으면 언제든지 multi-turn 대화가 종료될 수 있습니다. <code>SessionEndedRequest</code> 타입 요청을 받은 후에는 extension이 어떠한 응답(사용 종료 안내말 또는 인사말)을 보내더라도 CEK가 이를 무시하게 됩니다.</p>
</div>
