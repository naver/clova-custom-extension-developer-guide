<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

<!-- Start of the shared content: CEKHTTPMessageReference -->

# HTTP 메시지
CEK와 extension이 통신할 때 HTTP/1.1 프로토콜을 사용하며, 기본적인 HTTP 요청과 HTTP 응답을 주고 받습니다. CEK와 extension이 서로 통신할 때 HTTP 메시지 본문(body)에는 JSON 포맷의 메시지가 포함되어 있습니다. 여기에서는 CEK와 extension 사이에서 주고 받는 HTTP 메시지가 어떻게 구성되는지 설명합니다.

* [HTTP 헤더](#HTTPHeader)
* [HTTP 본문](#HTTPBody)

## HTTP 헤더 {#HTTPHeader}
CEK가 extension으로 분석된 사용자의 발화 정보를 보낼 때 HTTP 요청을 사용합니다. 이때 HTTP 요청 헤더는 다음과 같이 구성됩니다.

{% raw %}

```
POST /APIpath HTTP/1.1
Host: your.extension.endpoint
Content-Type: application/json;charset-UTF-8
Accept: application/json
Accept-Charset: utf-8
SignatureCEK: {{ SignatureCEK }}
```
{% endraw %}

* HTTP/1.1 버전으로 HTTPS 통신을 수행하며, method로 POST 방식을 사용합니다.
* Host와 요청 대상 path는 extension 개발자가 미리 정의해 둔 URI로 채워집니다.
* 본문의 데이터 형식은 JSON 형식으로 UTF-8 인코딩으로 되어 있습니다.
* `SignatureCEK` 필드와 RSA 공개 키를 이용하여 CLOVA로부터 전송된 요청인지 검증할 수 있습니다.

이와 반대로 extension이 CLOVA로 처리 결과를 보낼 때 HTTP 응답을 사용합니다. 이때 HTTP 응답 헤더는 다음과 같이 설정하면 됩니다.
{% raw %}
```
HTTP/1.1 200 OK
Content-Type: application/json;charset-UTF-8
```
{% endraw %}
* CEK가 보낸 HTTP 요청에 대한 응답으로 처리 결과를 전달합니다.
* 본문의 데이터 형식은 JSON 포맷으로 되어 있으며, UTF-8 인코딩을 사용합니다.

## HTTP 본문 {#HTTPBody}
HTTP 요청 메시지와 응답 메시지의 본문은 JSON 포맷이며, 분석된 사용자의 발화 정보나 extension의 처리 결과가 담긴 정보입니다. 각 메시지의 구성은 어떤 종류의 extension을 사용하느냐에 따라 달라집니다. 메시지의 구성에 대한 자세한 정보는 [custom extension 메시지](#CustomExtMessage)를 참조합니다.

<!-- End of the shared content -->
