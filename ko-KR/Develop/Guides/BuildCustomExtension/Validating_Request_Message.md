<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

### 요청 메시지 검증 {#RequestMessageValidation}

<!-- Start of the shared content: CEKRequestMessageValidation -->

Extension이 CEK로부터 HTTP 요청을 받을 때, 해당 요청이 제 3 자가 아닌 CLOVA로부터 전송된 신뢰할 수 있는 요청인지 검증할 필요가 있습니다. [HTTP 헤더](/Develop/References/HTTP_Message.md#HTTPHeader)에 있는 `SignatureCEK`와 RSA 공개 키를 사용하여 다음과 같이 요청 메시지를 검증할 수 있습니다.

<ol>
  <li>CLOVA의 서명용 RSA 공개 키를 아래 URI에서 다운로드하십시오.<br />
    <pre><code>{{ book.ServiceEnv.PublicKeyURIforCEKMessageValidation }}</code></pre>
  </li>
  <li><a href="/Develop/References/HTTP_Message.md#HTTPHeader">HTTP 헤더</a>에서 <code>SignatureCEK</code> 필드의 값을 확보하십시오.<br />
    <code>SignatureCEK</code> 필드의 값은 HTTP 요청 메시지의 본문을 Base64로 인코딩한 <a href="https://tools.ietf.org/html/rfc3447" target="_blank">RSA PKCS#1 v1.5</a> 서명 값(signature)입니다.</li>
  <li>1 번 항목에서 다운로드한 RSA 공개 키와 2 번 항목에서 획득한 <code>SignatureCEK</code> 헤더 값을 이용하여 <a href="https://tools.ietf.org/html/rfc3447#section-5.2" target="_blank">검증(verify)</a>하십시오.</li>
</ol>

다음은 요청 메시지를 검증하는 예제 코드입니다.
```java
String signatureStr = req.getHeader("SignatureCEK");
byte[] body = getBody(req);

String publicKeyStr = downloadPublicKey();
publicKeyStr = publicKeyStr.replaceAll("\\n", "")
    .replaceAll("-----BEGIN PUBLIC KEY-----", "")
    .replaceAll("-----END PUBLIC KEY-----", "");
X509EncodedKeySpec pubKeySpec = new X509EncodedKeySpec(Base64.getDecoder().decode(publicKeyStr));

KeyFactory keyFactory = KeyFactory.getInstance("RSA");
PublicKey pubKey = keyFactory.generatePublic(pubKeySpec);
Signature sig = Signature.getInstance("SHA256withRSA");
sig.initVerify(pubKey);
sig.update(body);

byte[] signature = Base64.getDecoder().decode(signatureStr);
boolean valid = sig.verify(signature);
```

<div class="note">
  <p><strong>Note!</strong></p>
  <p>메시지 검증에 실패하면 해당 요청을 폐기해야 합니다.</p>
</div>

<!-- End of the shared content -->
