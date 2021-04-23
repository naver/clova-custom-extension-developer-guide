# 문서 정보
이 문서는 CLOVA custom extension을 개발할 수 있도록 디자인 가이드라인과 CEK 플랫폼에 대한 개발 가이드 및 API 레퍼런스 그리고 CLOVA developer console에 대한 가이드를 제공합니다. 대상 독자는 CEK를 사용하여 온라인 콘텐츠 및 서비스를 제공하려는 custom extension 개발자입니다.

<div class="note">
  <p><strong>Note!</strong></p>
  <p>CLOVA는 개발이 계속 진행되고 있습니다. 따라서, 문서의 내용은 언제든지 변경될 수 있습니다.</p>
</div>

## 연락처
문서와 관련하여 궁금한 사항은 지정된 CLOVA 제휴 담당자나 <a href="{{ book.ServiceEnv.DeveloperCenterForumURI }}" target="_blank">{{ book.ServiceEnv.DeveloperCenterName }} 포럼</a>에 문의합니다.

## 문서 변경 이력

이 문서의 변경 이력은 다음과 같습니다.

<table>
  <thead>
    <tr>
      <th style="width:12%">배포 일자</th><th style="width:88%">이력 사항</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>2021-01-18</td>
      <td>
        <ul>
          <li>비정상 동작하는 custom extension의 운영 중단 유예 기간을 3 개월에서 1 개월로 변경함</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2020-11-26</td>
      <td>
        <ul>
          <li><a href="/Develop/References/Custom_Extension_Message.md#CustomExtSpeechInfoObject">SpeechInfoObject</a>의 value 필드에 제약 사항을 추가함</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2020-09-28</td>
      <td>
        <ul>
          <li><a href="/TermsAndPolicy/Terms_And_Policy.md">준수사항 및 운영정책</a> 설명을 별도 페이지로 분리함</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2020-06-24</td>
      <td>
        <ul>
          <li>Clova의 표기를 CLOVA로 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-08-19</td>
      <td>
        <ul>
          <li>API 레퍼런스와 developer console 가이드의 목차 수준을 한 단계씩 올림</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-08-05</td>
      <td>
        <ul>
          <li>Custom extension 디자인 가이드라인 문서를 <a href="/Design/Design_Custom_Extension.md">Custom extension 설계</a>, <a href="/Design/Supported_Audio_Format.md">플랫폼 지원 오디오 포맷</a>, 콘텐츠 제공 시 준수 사항 페이지로 분리함</li>
          <li><a href="/Design/Supported_Audio_Format.md">플랫폼 지원 오디오 포맷</a> 내용에 CLOVA가 지원하는 컨테이너 포맷 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-07-31</td>
      <td>
        <ul>
          <li>CLOVA developer guide에서 CLOVA custom extension guide 문서로 분리됨</li>
          <li>일부 링크 오류 수정 및 오탈자 교정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-07-02</td>
      <td>
        <ul>
          <li><a href="/DevConsole/Guides/Register_Interaction_Model.md">Interaction 모델 등록하기</a>에서 발화 예시 등록 및 TSV 파일 업로드와 관련된 제약 사항을 설명에 추가</li>
          <li>일부 예제 오탈자 교정 및 노트 상자 수준 조정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-06-10</td>
      <td>
        <ul>
          <li>새로운 콘텐츠 재생을 위해 <a href="/Design/Design_Custom_Extension.md">Custom extension 설계</a>의 <a href="/Design/Design_Custom_Extension.md#BuiltinIntent">Built-in intent</a>에 Clova.RequestAlternativesIntent 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-05-20</td>
      <td>
        <ul>
          <li><a href="/Develop/References/Custom_Extension_Message.html#CustomExtSpeechInfoObject">SpeechInfoObject</a>의 token, value 필드</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-04-01</td>
      <td>
        <ul>
          <li>Extension이 클라이언트의 음성(TTS) 재생 상태를 보고 받을 수 있도록 <a href="/Develop/References/Custom_Extension_Message.html#CustomExtSpeechInfoObject">SpeechInfoObject</a>에 token 필드를 추가하고 <a href="/Develop/Guides/Monitor_TTS_Playback_Status.md">음성 재생 상태 확인하기</a> 가이드 문서를 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-03-25</td>
      <td>
        <ul>
          <li>HLS 음원 제공을 위해 contentType 필드를 custom extension 메시지의 <a href="/Develop/References/Custom_Extension_Message.html#CustomExtSpeechInfoObject">SpeechInfoObject</a>에 추가</li>
          <li>일부 링크 오류 및 예제 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-03-13</td>
      <td>
        <ul>
          <li>일부 레퍼런스 문서의 내용 순서 수정</li>
          <li>내외부 피드백을 문서에 반영</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-02-26</td>
      <td>
        <ul>
          <li>Extension이라는 표현이 custom extension과 CLOVA Home extension을 포괄하고 있어, 문서에서 extension만 단독으로 사용된 부분에서 둘 중 어느 것을 뜻하는지 명시함</li>
          <li>UI 요소를 제외한 것에 대해 URL이라는 표현 대신 URI로 수정함</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-01-25</td>
      <td>
        <ul>
          <li>다이어그램 일부 스타일 수정 및 표의 열 간격 조정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2019-01-07</td>
      <td>
        <ul>
          <li>문서에 사용되 일부 UML 다이어그램의 스타일 통일</li>
          <li>문서 이력의 일부 표기 오류 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-12-24</td>
      <td>
        <ul>
          <li><a href="/Design/Design_Custom_Extension.md">Custom extension 설계</a> 문서의 오디오 콘텐츠 재생 유형 설명에서 예제 시나리오에 잘못 표기된 지시 메시지의 이름을 수정</li>
          <li><a href="/Develop/Guides/Provide_Audio_Content.md">오디오 콘텐츠 제공하기</a> 설명에서 CIC 명세 도입 시 이를 독자가 인지할 수 있도록 표현을 수정</li>
          <li>일부 시퀀스 다이어그램에 잘못 표기된 노드의 유형을 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-12-22</td>
      <td>
        <ul>
          <li><a href="/Develop/Guides/Link_User_Account.md">사용자 계정 연결하기</a> 가이드의 <a href="/Develop/Guides/Link_User_Account.md#BuildAuthServer">인증 서버 구축</a> 설명에서 redirect_uri 파라미터 중 잘못 명시된 vendorId 필드를 제거함</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-10-13</td>
      <td>
        <ul>
          <li><a href="/DevConsole/Guides/Register_Custom_Extension.md#InputExtensionInfo">Extension 기본 정보 입력</a>에 호출 이름을 한 개 이상 최대 세 개까지 등록할 수 있음을 명시</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-09-21</td>
      <td>
        <ul>
          <li>CLOVA에서 전달하는 메시지의 검증을 위해 <a href="/Develop/References/HTTP_Message.md#HTTPHeader">HTTP 헤더</a>에 SignatureCEK 필드 설명을 추가하고 <a href="/Develop/Guides/Build_Custom_Extension.md">custom extension 만들기</a> 문서에 요청 메시지 검증 절을 추가</li>
          <li>일부 잘못된 코드 예제를 수정</li>
          <li>일부 잘못된 링크를 수정</li>
          <li>일부 사용자 접점에 있는 Extension 표기를 Skill로 변경(UI 캡처 이미지 함께 업데이트)</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-09-07</td>
      <td>
        <ul>
          <li>디자인 가이드라인의 <a href="/Design/Supported_Audio_Format.md">플랫폼 지원 오디오 포맷</a>에 오디오 콘텐츠별 음질 관련 속성과 음량에 대한 권고 사항 추가</li>
          <li>예제 설명 중 "yourdomain.com"으로 표시된 예제를 문서 작성용 도메인 이름인 "example.com"으로 변경</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-08-24</td>
      <td>
        <ul>
          <li><a href="/Develop/References/Custom_Extension_Message.md">Custom extension 메시지</a> <a href="/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest">EventRequest</a> 요청 타입의 예제에서 오류 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-08-09</td>
      <td>
        <ul>
          <li><a href="/Develop/Guides/Build_Custom_Extension.md#ProvidingMetaDataForDisplay">오디오 콘텐츠의 메타 정보 제공</a> 절에서 일부 오타 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-07-09</td>
      <td>
        <ul>
          <li>Custom extension의 <a href="/Design/Design_Custom_Extension.md#DefineInvocationName">이름 정의</a>에 대한 가이드라인 추가</li>
          <li>Custom extension의 <a href="/Design/Rules_For_Content.md">콘텐츠 제공 시 준수 사항</a>에 대한 가이드라인 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-06-25</td>
      <td>
        <ul>
          <li>Custom extension의 <a href="/Design/Design_Custom_Extension.md#DecideSoundOutputType">응답 유형</a>에 대한 가이드라인 추가</li>
          <li>Custom extension 만들기 문서에 <a href="/Develop/Guides/Provide_Audio_Content.md">오디오 콘텐츠 제공하기</a> 절 추가</li>
          <li>Custom extension 메시지의 <a href="/Develop/References/Custom_Extension_Message.md#CustomExtRequestType">요청 타입</a>에 <a href="/Develop/References/Custom_Extension_Message.md#CustomExtEventRequest">EventRequest 타입</a> 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-05-14</td>
      <td>
        <ul>
          <li>HTTP 요청 메시지에 헤더(SignatureCEK, SignatureCEKCertChainUrl) 추가 및 요청 메시지 검증 절 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-04-02</td>
      <td>
        <ul>
          <li>CLOVA developer console의 일부 UI 업데이트 적용</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-03-05</td>
      <td>
        <ul>
          <li><a href="/Develop/Tutorials/Introduction.md">튜토리얼</a> 페이지에 <a href="/Develop/Tutorials/Use_Builtin_Type_Slots.md">사용자가 입력한 정보 활용하기</a> 페이지 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-02-05</td>
      <td>
        <ul>
          <li>Extension 시작 호출(<a href="/Develop/Guides/Build_Custom_Extension.md#HandleLaunchRequest">LaunchRequest</a>)에 대한 설명 수정 및 <a href="/Design/Design_Custom_Extension.md">Custom extension 설계</a> 문서 반영</li>
          <li>CEK와 extension간 통신에 사용되는 <a href="/Develop/CEK_Overview.md#WhatisCEK">HTTP 프로토콜 버전</a> 명시</li>
          <li><a href="/Develop/Tutorials/Introduction.md">튜토리얼</a> 페이지에 <a href="/Develop/Tutorials/Handle_Builtin_Intents.md">기본적인 의사 표현 처리하기</a> 페이지 추가</li>
          <li>Extension 서버에서 사용해야 할 <a href="/DevConsole/Guides/Register_Custom_Extension.md#SetServerConnection">포트</a>를 명시</li>
          <li>일부 문서 오류 교정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-01-29</td>
      <td>
        <ul>
          <li><a href="/DevConsole/Guides/Register_Custom_Extension.md#SetServerConnection">Extension 서버 연동 설정</a> 전 연결 확인하는 방법 추가 및 <a href="/DevConsole/Guides/Test_Custom_Extension.md#TestOnCLOVAApp">테스터 ID 적용 자동화</a>에 대한 안내 추가</li>
          <li>CLOVA developer console의 일부 UI 업데이트 적용</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-01-22</td>
      <td>
        <ul>
          <li><a href="/Design/Supported_Audio_Format.md">플랫폼 지원 오디오 포맷</a>을 디자인 가이드라인에 추가</li>
          <li><a href="/Develop/Tutorials/Introduction.md">튜토리얼</a> 페이지와 <a href="/Develop/Tutorials/Build_Simple_Extension.md">기초적인 extension 만들기</a> 페이지 추가</li>
          <li><a href="/DevConsole/Guides/Register_Interaction_Model.md#AddCustomSlotType">Built-in intent 목록 표시</a>, <a href="/DevConsole/Guides/Deploy_Custom_Extension.md#InputComplianceInfo">심사 신청</a> 시 심사 요청 메시지 작성을 위한 UI 추가</li>
          <li>UML 다이어그램의 이미지 포맷 변경</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-01-08</td>
      <td>
        <ul>
          <li>플랫폼 구현 상황에 맞게 <a href="/Design/Design_Custom_Extension.md#DefineInteractionModel">built-in intent</a>에 대한 설명 수정</li>
          <li><a href="/Develop/Examples/Extension_Examples.md">Extension 예제</a> 페이지 추가</li>
          <li><strong>테스터 ID</strong> 필드 추가에 따른 <a href="/DevConsole/Guides/Test_Custom_Extension.md">Extension 테스트하기</a> 설명 업데이트</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2018-01-02</td>
      <td>
        <ul>
          <li>일부 문서 오류, 오타 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-12-18</td>
      <td>
        <ul>
          <li><a href="/DevConsole/Guides/Register_Interaction_Model.md">Interaction 모델 등록하기</a>에서 <a href="/Design/Design_Custom_Extension.md#DefineInteractionModel">interaction 모델 정의</a> 절 내용을 <a href="/Design/Design_Custom_Extension.md">Custom extension 설계</a> 문서로 이동</li>
          <li><a href="/Design/Design_Custom_Extension.md#DefineInteractionModel">Interaction 모델 정의</a> 절 내용에 <a href="/Design/Design_Custom_Extension.md#UtteranceExample">발화 예시</a>문 작성 가이드라인 추가</li>
          <li><a href="/DevConsole/Guides/Test_Custom_Extension.md">Extension 테스트하기</a>에 테스트 모드 사용하기 추가</li>
          <li>UI 개선에 따른 이미지 및 설명 수정</li>
          <li><a href="/DevConsole/Guides/Update_Custom_Extension.md">Extension 업데이트하기</a>, <a href="/DevConsole/Guides/Remove_Custom_Extension.md">Extension 중지 및 삭제하기</a> 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-12-11</td>
      <td>
        <ul>
          <li><a href="/Design/Design_Custom_Extension.md">Custom extension 설계</a> 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-12-04</td>
      <td>
        <ul>
          <li>사용자 multi-turn 대화를 위해 reprompt 필드를 <a href="/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage">응답 메시지</a>에 추가</li>
          <li>일부 문서 오류 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-11-06</td>
      <td>
        <ul>
          <li><a href="/Develop/References/Custom_Extension_Message.md">Custom extension 메시지</a> 중 요청 메시지에서 context.System.device.displayType 필드의 이름을 context.System.device.display로 바꾸고 하위 필드 구성을 변경</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-10-30</td>
      <td>
        <ul>
          <li><a href="/DevConsole/ClovaDevConsole_Overview.md">CLOVA developer console 개요</a> 설명 추가</li>
          <li><a href="/DevConsole/Guides/Register_Custom_Extension.md">Extension 등록하기</a> 가이드 추가</li>
          <li><a href="/DevConsole/Guides/Register_Interaction_Model.md">Interaction 모델 등록하기</a> 가이드 추가</li>
          <li><a href="/DevConsole/Guides/Deploy_Custom_Extension.md">Extension 배포하기</a> 가이드 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-10-23</td>
      <td>
        <ul>
          <li><a href="/Develop/References/Custom_Extension_Message.md">Custom extension 메시지</a> 중 요청 메시지에 context.System.device.displayType 필드 추가</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-10-16</td>
      <td>
        <ul>
          <li>일부 문서 이미지 수정 및 문서 오류 교정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-09-04</td>
      <td>
        <ul>
          <li>일부 문서 오류 수정</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-08-14</td>
      <td>
        <ul>
          <li><a href="/Develop/Guides/Do_Multiturn_Dialog.md">Multi-turn 대화 수행하기</a>절 추가 및 sessionAttributes 필드 설명 업데이트</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-07-07</td>
      <td>
        <ul>
          <li><a href="/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage">Custom extension 응답 메시지</a>의 <a href="/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage">outputSpeech</a> 객체 구성 업데이트 반영</li>
          <li><a href="/Glossary.md">용어집 추가</a></li>
          <li>CEK 메시지 포맷 파트의 목차 업데이트</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-07-03</td>
      <td>
        <ul>
          <li>CEK 문서 이미지 내용 업데이트</li>
          <li>문서 리뷰 결과 반영</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>2017-06-19</td>
      <td>
        <ul>
          <li>CEK 문서 파트 작성</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>
