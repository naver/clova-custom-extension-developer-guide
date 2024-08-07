<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

# 플랫폼 지원 오디오 포맷

Custom extension을 통해 오디오 콘텐츠를 제공한다면 반드시 CLOVA가 지원하는 오디오 압축 포맷으로 음원을 제공해야 합니다.

<!-- Start of the shared content: SupportedAudioFormat -->

CLOVA가 지원하는 오디오 압축 포맷(codec)은 다음과 같습니다.

| 오디오 압축 포맷                     | 라이선스 비용 |
|----------------------------------|-----------|
| MPEG-1 or MPEG-2 Audio Layer III | 무료       |

CLOVA가 지원하는 파일 확장자와 MIME 타입은 다음과 같습니다.

| 파일확장자  | MIME 타입                 | 비고                           |
|-------------|-------------------------------|-------------------------------|
| MP3         | audio/mpeg                    | <!-- -->                      |
| M3U8        | application/vnd.apple.mpegurl | HTTP Live Streaming 사용       |

<!-- End of the shared content -->

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>CLOVA가 지원하는 오디오 압축 포맷은 더 늘어날 수 있습니다.</p>
</div>

<div class="warning">
  <p><strong>Warning!</strong></p>
  <p>CLOVA가 지원하지 않는 오디오 압축 포맷으로 음원을 제공하면 클라이언트가 정상적으로 음원을 재생하지 못할 수 있습니다.</p>
</div>

제공하려는 오디오 콘텐츠 타입에 따라 다음과 같은 음질 관련 속성과 음량(loudness)을 따르도록 권고합니다.

| 오디오 콘텐츠 타입        | 샘플링 주파수, 비트 심도, 채널 | 음량(loudness)  | 비고                                     |
|-----------------------|-------------------------|--------------- |----------------------------------------|
| 음악                   | 44100Hz, 16bit, stereo  | -10(±1) LUFS  | 비트 박스 형태의 음악은 -17(±1) LUFS로 맞춥니다. |
| 음향효과       | 44100Hz, 16bit, stereo  | -18(±1) LUFS  |                                         |
| 오디오 북               | 44100Hz, 16bit, stereo  | -12(±1) LUFS  |                                         |
| 앰비언트 장르 음악이나 소리  | 44100Hz, 16bit, stereo  | -25(±1) LUFS  | 파도 소리, 빗소리와 같은 형태의 오디오 콘텐츠이며, 각 콘텐츠의 특성에 따라 적절히 음량을 조절해야 합니다. |
